//
//  CustomKeyboardButton.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class CustomKeyboardButton: UIButton {
    
    var buttonValue: Int

    var label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    
    init(label: Int) {
        self.buttonValue = label
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomKeyboardButton {
    
    func configureLabel() {
        addSubview(label)
        label.text = String(buttonValue)
        label.fillOther(view: self)
    }
    
}
