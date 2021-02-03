//
//  ConverterPanel.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

class ConverterPanel: UIView {
    
    var currency: String?
    var bgColor: UIColor? {
        didSet {
            self.backgroundColor = bgColor
        }
    }
        
    convenience init() {
        self.init(color: nil, currency: nil)
    }
    
    init(color bgColor: UIColor?, currency: String?) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bgColor = bgColor
        self.currency = currency
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
