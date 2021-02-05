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
        configureKeyboardRows()
    }
    
    private func createKeyboardRows() {
        for index in 0...3 {
            let row = CustomKeyboardRow(keyboardRowIndex: index)
            
            allRows[index] = row
            view.addSubview(allRows[index]!)
        }
    }
    
    private func configureKeyboardRows() {
        for (_, row) in allRows {
            if row.id == 0 {
                // This is the first row, topAnchors must align to the `safeAreaLayoutGuide`
                row.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            } else {
                // These are the other rows. Their constraints should be relative to the previous row.
                row.topAnchor.constraint(equalTo: allRows[row.id - 1]!.bottomAnchor).isActive = true
            }
            
            // These contraints are shared by all rows
            NSLayoutConstraint.activate([
                row.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
                row.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
                row.heightAnchor.constraint(equalToConstant: 105)
            ])
        }
    }
    
}
