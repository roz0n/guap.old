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
        spacing = C.spacers.keyboard.leading
        
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
            let button = CustomKeyboardButton(keyValue: KeyboardButtonValues.rows[id]![index - 1])
            
            addKeyboardGesture(to: button)
            buttons.append(button)
            
            addArrangedSubview(buttons[index - 1])
        }
    }
    
}

// MARK: - Gesture handlers

extension CustomKeyboardRow {
    
    func addKeyboardGesture(to button: UIButton) {
        let keyboardButtonTap = UITapGestureRecognizer(target: self, action: #selector(keyboardButtonTapped))
        button.addGestureRecognizer(keyboardButtonTap)
    }
    
    @objc func keyboardButtonTapped(_ sender: UITapGestureRecognizer) {
        let button = sender.view as? CustomKeyboardButton
        print("Tapped custom keyboard button: \(button?.keyValue)")
    }
    
}
