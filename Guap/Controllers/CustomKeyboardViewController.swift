//
//  CustomKeyboardViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class CustomKeyboardViewController: UIViewController {
    
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
        //        configureButtons()
        configureGestures()
    }
    
}

// MARK: - Gestures

extension CustomKeyboardViewController {
    
    private func configureGestures() {
        for (_, row) in keyboardRows {
            for button in row.buttons {
                let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardButtonTapped))
                button.addGestureRecognizer(tap)
            }
        }
    }
    
    @objc func keyboardButtonTapped(_ sender: UITapGestureRecognizer) {
        let button = sender.view as? CustomKeyboardButton
        print("Tapped custom keyboard button: \(String(describing: button?.keyValue))")
    }
    
}

// MARK: - Keyboard row creation and layout

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
