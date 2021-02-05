//
//  CustomKeyboardViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class CustomKeyboardViewController: UIViewController {
    
    var allRows = [Int:CustomKeyboardRow]()
    
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
        createRows()
        configureRowsLayout()
    }
    
    private func createRows() {
        for index in 1...4 {
            let row = CustomKeyboardRow()
            allRows[index] = row
            view.addSubview(allRows[index]!)
        }
    }
    
    private func configureRowsLayout() {
        for (key, row) in allRows {
            if key == 1 {
                // This is the first row, topAnchors must align to the `safeAreaLayoutGuide`
                row.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            } else {
                // These are the other rows. Their constraints should be relative to the previous row.
                row.topAnchor.constraint(equalTo: allRows[key - 1]!.bottomAnchor).isActive = true
            }
            
            // These contraints are shared by all rows
            NSLayoutConstraint.activate([
                row.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                row.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                row.heightAnchor.constraint(equalToConstant: 105)
            ])
        }
    }
    
}
