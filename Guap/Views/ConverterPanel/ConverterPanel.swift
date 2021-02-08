//
//  ConverterPanel.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

class ConverterPanel: UIView {
    
    var currency: String?
    
    let stack: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        return stack
    }()
        
    convenience init() {
        self.init(currency: nil)
    }
    
    init(currency: String?) {
        super.init(frame: .zero)
        
        self.currency = currency
        self.addBorder(borders: [.Bottom], color: K.colors.borderGray, width: 1)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        stack.fillOther(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
