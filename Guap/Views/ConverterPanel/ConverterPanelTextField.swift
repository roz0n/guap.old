//
//  ConverterPanelTextField.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

class ConverterPanelTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = K.colors.white
        self.keyboardType = .numberPad
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
