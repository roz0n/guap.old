//
//  ConverterStatusBar.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class ConverterStatusBar: UIView {
    
    var currencyPill: ConverterStatusPill?
    var datePill: ConverterStatusPill?
    var ratePill: ConverterStatusPill?
    
    let stack: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20)
        stack.axis = .horizontal
        
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = K.colors.white
        
        // TODO: Why isn't this working?
        addBorder(borders: [.Bottom], color: K.colors.red, width: 10)
        
        createPills()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createPills() {
        currencyPill = ConverterStatusPill(labelText: "EUR to DOP", labelTextColor: K.colors.white, bgColor: K.colors.black)
        currencyPill?.widthAnchor.constraint(greaterThanOrEqualToConstant: 85).isActive = true
        currencyPill?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        datePill = ConverterStatusPill(labelText: "Thu 2 Feb 2021", labelTextColor: K.colors.black, bgColor: K.colors.white)
        datePill?.widthAnchor.constraint(lessThanOrEqualToConstant: 160).isActive = true
        datePill?.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        ratePill = ConverterStatusPill(labelText: "65.5623", labelTextColor: K.colors.white, bgColor: K.colors.green)
        ratePill?.widthAnchor.constraint(greaterThanOrEqualToConstant: 85).isActive = true
        ratePill?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
}

// MARK: - Layout methods

extension ConverterStatusBar {
    
    func configureLayout() {
        addSubview(stack)
        
        if let cp = currencyPill, let dp = datePill, let rp = ratePill {
            stack.addArrangedSubview(cp)
            stack.addArrangedSubview(dp)
            stack.addArrangedSubview(rp)
        }
        
        // TODO: Constants
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}
