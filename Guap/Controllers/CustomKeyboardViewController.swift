//
//  CustomKeyboardViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

protocol CustomKeyboardDelegate {
    func keyboardButtonWasTapped(_ sender: CustomKeyboardViewController, button: CustomKeyboardButton)
}

class CustomKeyboardViewController: UIViewController {
    
    var delegate: CustomKeyboardDelegate?
    var keyboardRows = [Int: CustomKeyboardRow]()
    
    let rowStack: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = K.spacers.keyboard.leading
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        configureRows()
        configureGestures()
    }
    
}

// MARK: - CustomKeyboardDelegate

extension CustomKeyboardViewController {
    
    func keyboardButtonWasTapped(_ sender: CustomKeyboardViewController, button: CustomKeyboardButton) {
        self.delegate?.keyboardButtonWasTapped(self, button: button)
    }
    
}

// MARK: - Gestures

extension CustomKeyboardViewController {
    
    private func configureGestures() {
        for (_, row) in keyboardRows {
            for button in row.buttons {
                let tap = UITapGestureRecognizer(target: self, action: #selector(buttonTap))
                button.addGestureRecognizer(tap)
            }
        }
    }
    
    @objc func buttonTap(_ sender: UITapGestureRecognizer) {
        let button = sender.view as? CustomKeyboardButton
        
        if let button = button {
            keyboardButtonWasTapped(self, button: button)
        }
    }
    
}

// MARK: - Create Keyboard Rows and Configure Layout

extension CustomKeyboardViewController {
    
    private func configureRows() {
        createKeyboardRows()
        createKeyboardButtons()
        configureRowStack()
    }
    
    private func createKeyboardRows() {
        for index in 0...3 {
            let row = CustomKeyboardRow(keyboardRowIndex: index)
            
            keyboardRows[index] = row
            rowStack.addArrangedSubview(keyboardRows[index]!)
        }
    }
    
    private func createKeyboardButtons() {
        for (_, row) in keyboardRows {
            for buttonIndex in 1...3 {
                let button = CustomKeyboardButton(keyValue: KeyboardButtonValues.rows[row.id]![buttonIndex - 1])
                
                row.buttons.append(button)
                row.addArrangedSubview(row.buttons[buttonIndex - 1])
            }
        }
    }
    
    private func configureRowStack() {
        view.addSubview(rowStack)
        
        NSLayoutConstraint.activate([
            rowStack.topAnchor.constraint(equalTo: view.topAnchor),
            rowStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.spacers.keyboard.leading),
            rowStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: K.spacers.keyboard.trailing),
            rowStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
