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
            rowStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            rowStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            rowStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rowStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
}
