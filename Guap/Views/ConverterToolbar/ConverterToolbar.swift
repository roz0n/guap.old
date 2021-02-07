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
    
    var convertButton: UIButton = ConverterToolbarButton(icon: UIImage(systemName: "arrow.triangle.2.circlepath", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), iconColor: K.colors.white, bgColor: K.colors.yellow)
    var swapButton: UIButton = ConverterToolbarButton(icon: UIImage(systemName: "arrow.left.arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), iconColor: K.colors.white, bgColor: K.colors.red)
    var shareButton: UIButton = ConverterToolbarButton(icon: UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), iconColor: K.colors.white, bgColor: K.colors.blue)
    
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
        convertButton.layer.cornerRadius = 5
        swapButton.layer.cornerRadius = 5
        shareButton.layer.cornerRadius = 5
    }
    
    func configureLayout() {
        addSubview(buttonStack)
        buttonStack.addArrangedSubview(swapButton)
        buttonStack.addArrangedSubview(convertButton)
        buttonStack.addArrangedSubview(shareButton)
        buttonStack.fillOther(view: self)
    }
    
}
