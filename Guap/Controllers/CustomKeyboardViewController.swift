//
//  CustomKeyboardViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class CustomKeyboardViewController: UIViewController {
    
    var allRows = [Int: CustomKeyboardRow]()
    var allButtons = [Int: [CustomKeyboardButton]]()
    
    let rowStack: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = C.spacers.keyboard.leading
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        
        configureRows()
    }
}

// MARK: - Keyboard row creation and layout

extension CustomKeyboardViewController {
    
    private func configureRows() {
        createKeyboardRows()
        configureRowStack()
    }
    
    private func createKeyboardRows() {
        for index in 0...3 {
            let row = CustomKeyboardRow(keyboardRowIndex: index)
            
            allRows[index] = row
            rowStack.addArrangedSubview(allRows[index]!)
        }
    }
    
    private func configureRowStack() {
        view.addSubview(rowStack)
        
        NSLayoutConstraint.activate([
            rowStack.topAnchor.constraint(equalTo: view.topAnchor, constant: C.spacers.keyboard.top),
            rowStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.spacers.keyboard.leading),
            rowStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.spacers.keyboard.trailing),
            rowStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: C.spacers.keyboard.bottom)
        ])
    }
    
}
