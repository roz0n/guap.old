//
//  ERDataManager.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/2/21.
//

import UIKit

class ERDataManager {
    
    static let shared = ERDataManager()
    
    private func getEndpoint() -> String {
        let baseEndpoint = "https://v6.exchangerate-api.com/v6/"
        var apiKey: String?
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let keys = NSDictionary(contentsOfFile: path)!
            apiKey = keys["exchangeRateApiKey"] as? String
        }
        
        return baseEndpoint + apiKey! + "/"
    }
    
    func getPairConversion(base baseCurrency: String, target targetCurrency: String, completed: @escaping (ERPairConversionModel?, String?) -> Void) {
        let endpoint = getEndpoint() + "pair/\(baseCurrency)/\(targetCurrency)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "URL parsing error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(nil, "Network error fetching paired conversion")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Error fetching pair conversion: \(baseCurrency) to \(targetCurrency)")
                return
            }
            
            guard let data = data else {
                completed(nil, "Invalid pair conversion data retrived from the server")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let parsed = try decoder.decode(ERPairConversionModel.self, from: data)
                completed(parsed, nil)
            } catch {
                completed(nil, "Error parsing pair conversion data to JSON")
            }
            
        }
        
        task.resume()
    }
    
}
