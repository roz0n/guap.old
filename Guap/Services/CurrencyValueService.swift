//
//  CurrencyValueService.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/13/21.
//

import Foundation

class CurrencyValueService {
    
    static let shared = CurrencyValueService()
    private var localeCache = [String: Locale]()
    
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
    
    func formatFieldValue(of field: ConverterPanelField) {
        guard let text = field.amountLabel.text else { return }
        
        if let doubleValue = Double(text) {
            if let currencyValue = CurrencyValueService.shared.formatCurrency(doubleValue) {
                field.amountLabel.text! = currencyValue
            } else {
                field.amountLabel.text! = String(doubleValue)
            }
        }
    }
    
    func formatCurrency(_ value: Double) -> String? {
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        
        return formatter.string(from: NSNumber(value: value))
    }
    
    func calculatePair(base: Double, rate: Double) -> Double {
        return (base * rate).rounded()
    }
    
}

