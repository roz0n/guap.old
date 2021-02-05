//
//  CustomKeyboardButton.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class CustomKeyboardButton: UIButton {
    
    var keyValue: String

    var label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    
    init(keyValue: String) {
        self.keyValue = keyValue
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGreen
        
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomKeyboardButton {
    
    func configureLabel() {
        addSubview(label)
        
        label.text = keyValue
        label.fillOther(view: self)
    }
    
}
