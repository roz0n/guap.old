//
//  CustomKeyboardButton.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class CustomKeyboardButton: UIButton {
    
    var keyValue: String
    
    let labelContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 3
        view.layer.borderColor = K.colors.borderGray.cgColor
        view.makeCircular()
        
        return view
    }()
    
    var label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    
    init(keyValue: String) {
        self.keyValue = keyValue
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout

extension CustomKeyboardButton {
    
    private func configureLabel() {
        label.text = keyValue
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.tintColor = K.colors.black
        label.fillOther(view: labelContainer)
    }
    
    private func configureLayout() {
        addSubview(labelContainer)
        labelContainer.addSubview(label)
        configureLabel()
        
        NSLayoutConstraint.activate([
            labelContainer.widthAnchor.constraint(equalToConstant: 90),
            labelContainer.heightAnchor.constraint(equalToConstant: 90),
            labelContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
