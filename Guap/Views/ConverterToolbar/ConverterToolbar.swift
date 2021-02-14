//
//  ConverterToolbar.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

class ConverterToolbar: UIView {
    
    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: K.spacers.toolbar.padding, leading: K.spacers.toolbar.padding, bottom: K.spacers.toolbar.padding, trailing: K.spacers.toolbar.padding)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = K.spacers.toolbar.stack
        
        return stack
    }()
    
    let convertButton: UIButton = ConverterToolbarButton(icon: UIImage(systemName: K.icons.ConvertCurrency, withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), iconColor: K.colors.white, bgColor: K.colors.yellow)
    let clearButton: UIButton = ConverterToolbarButton(icon: UIImage(systemName: K.icons.ClearCurrency, withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), iconColor: K.colors.white, bgColor: K.colors.red)
    let swapButton: UIButton = ConverterToolbarButton(icon: UIImage(systemName: K.icons.ShareCurrency, withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), iconColor: K.colors.white, bgColor: K.colors.blue)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        configureLayout()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout

extension ConverterToolbar {
    
    func configureButtons() {
        convertButton.layer.cornerRadius = K.styles.cornerRadius
        clearButton.layer.cornerRadius = K.styles.cornerRadius
        swapButton.layer.cornerRadius = K.styles.cornerRadius
    }
    
    func configureLayout() {
        addSubview(buttonStack)
        buttonStack.addArrangedSubview(clearButton)
        buttonStack.addArrangedSubview(convertButton)
        buttonStack.addArrangedSubview(swapButton)
        buttonStack.fillOther(view: self)
    }
    
}
