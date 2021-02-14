//
//  CurrencyValueService.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/13/21.
//

import Foundation

class CurrencyValueService {
    
    static let shared = CurrencyValueService()
    
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
        // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        // https://stackoverflow.com/questions/41558832/how-to-format-a-double-into-currency-swift-3
        // formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        
        return formatter.string(from: value as NSNumber)
    }
    
    func calculatePair(base: Double, rate: Double) -> Double {
        return (base * rate).rounded()
    }
    
}

