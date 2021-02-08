//
//  K.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/3/21.
//

import UIKit

// MARK: - Text and icon constants

struct K {
    
    static let AppName = "Guap"
    
    struct defaults {
        static let BaseCurrency = "EUR"
        static let TargetCurrency = "DOP"
    }
    
    struct buttons {
        static let Convert = "Convert"
        static let Reset = "Reset"
    }
    
    struct icons {
        static let HomeSettings = "gearshape.2.fill"
        static let HomeHistory = "clock.fill"
        static let SwapCurrency = "arrow.left.arrow.right"
        static let ShareCurrency = "square.and.arrow.up"
        static let ConvertCurrency = "arrow.triangle.2.circlepath"
    }
    
}

// MARK: - Colors and styling constants

extension K {
    
    struct colors {
        static let white = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        static let black = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        
        static let red = UIColor(red: 1, green: 0.129, blue: 0.129, alpha: 1)
        static let blue = UIColor(red: 0.054, green: 0.432, blue: 1, alpha: 1)
        static let green = UIColor(red: 0.095, green: 0.738, blue: 0.366, alpha: 1)
        static let yellow = UIColor(red: 1, green: 0.898, blue: 0, alpha: 1)
        
        static let headerGray = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        static let borderGray = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        
        static let textGray = UIColor(red: 0.587, green: 0.587, blue: 0.587, alpha: 1)
    }
    
    struct styles {
        static let cornerRadius = CGFloat(5)
    }
    
}

// MARK: - Layout constants

extension K {
    
    struct spacers {
        struct panels {            
            struct buttons {
                static let top = CGFloat(10)
                static let trailing = CGFloat(-10)
            }
            
            struct fields {
                static let leading = CGFloat(10)
            }
        }
        
        struct toolbar {
            static let stack = CGFloat(18)
            static let padding = CGFloat(18)
        }
        
        struct keyboard {
            static let top = CGFloat(12)
            static let bottom = CGFloat(-12)
            static let leading = CGFloat(10)
            static let trailing = CGFloat(-10)
        }
    }
    
    struct heights {
        struct converter {
            static let statusBar = CGFloat(50)
            static let panel = CGFloat(72)
            static let toolbar = CGFloat(72)
        }
    }
    
    struct widths {
        struct panel {
            static let icon = CGFloat(80)
            static let symbol = CGFloat(52)
        }
    }
    
}
