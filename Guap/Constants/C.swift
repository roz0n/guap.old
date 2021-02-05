//
//  C.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/3/21.
//

import CoreGraphics

struct C {
    
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
    }
    
    struct spacers {
        struct keyboard {
            static let top = CGFloat(12)
            static let bottom = CGFloat(-12)
            static let leading = CGFloat(10)
            static let trailing = CGFloat(-10)
        }
        
        struct panels {
            static let stack = CGFloat(0.25)
            
            struct buttons {
                static let top = CGFloat(10)
                static let trailing = CGFloat(-10)
            }
            
            struct fields {
                static let leading = CGFloat(10)
            }
        }
    }
    
    struct heights {
        struct converter {
            static let statusBar = CGFloat(48)
            static let container = CGFloat(80 * 2)
            static let toolbar = CGFloat(72)
        }
    }
    
}
