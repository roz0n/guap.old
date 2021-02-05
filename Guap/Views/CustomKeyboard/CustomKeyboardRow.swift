//
//  CustomKeyboardRow.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class CustomKeyboardRow: UIStackView {
    
    var id: Int
    var buttons = [CustomKeyboardButton]()
    
    init(keyboardRowIndex id: Int) {
        self.id = id
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemYellow
        axis = .horizontal
        distribution = .fillEqually
        spacing = 16
        
        configureButtons()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure keyboard buttons

extension CustomKeyboardRow {
    
    private func configureButtons() {
        for index in 1...3 {
            let button = CustomKeyboardButton(label: index)
            buttons.append(button)
            
            addArrangedSubview(buttons[index - 1])
            print("Adding button \(index) for row \(id)")
        }
    }
    
}
