//
//  ConverterPanelButton.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

class ConverterPanelButton: UIButton {
    
    var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    var type: CurrencyType?
    
    convenience init() {
        self.init(label: nil, role: nil)
    }
    
    init(label title: String?, role: CurrencyType?) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
