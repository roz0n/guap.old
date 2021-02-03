//
//  ConverterToolbar.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

class ConverterToolbar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let buttonStack: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 0.5
        
        return view
    }()
    
    let convertButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Convert", for: .normal)

        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reset", for: .normal)
        
        return button
    }()
    
}

// MARK: - Layout

extension ConverterToolbar {
    
    func configureLayout() {
        addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(convertButton)
        buttonStack.addArrangedSubview(resetButton)
        buttonStack.fillOther(view: self)
    }
    
}
