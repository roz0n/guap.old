//
//  ConverterDataManager.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/13/21.
//

import Foundation

class ConverterDataManager {
    
    static let shared = ConverterDataManager()
    private var localeCache = [String: Locale]()
    static var currencyStringToNumsPattern = "([^0-9.,]+)"
    
    func convertPair(base: Float, rate: Float) -> Float {
        return (base * rate)
    }
    
    func getLocaleFromCurrencyCode(_ currencyCode: String) -> Locale? {
        if let isCached = localeCache[currencyCode] {
            return isCached
        }
        
        let ids = Locale.availableIdentifiers
        var matches = [Locale]()
        
        // Obtain matches
        for id in ids {
            let tempLocale = Locale.init(identifier: id)
            let tempCode = tempLocale.currencyCode
            
            if (tempCode == currencyCode) {
                matches.append(tempLocale)
            }
        }
        
        guard matches.count > 0 else { return nil }
        
        // Sort matches and return first the first match
        let matchedLocale = matches.sorted { return $0.identifier < $1.identifier }.first
        localeCache[currencyCode] = matchedLocale
        
        return matchedLocale
    }
    
    func formatFloatAsCurrency(_ value: Float, to locale: Locale?) -> String? {
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currencyAccounting
        formatter.locale = Locale.current
        
        return formatter.string(from: NSNumber(value: value))
    }
    
}

