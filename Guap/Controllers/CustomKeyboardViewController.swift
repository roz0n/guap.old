//
//  CustomKeyboardViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class CustomKeyboardViewController: UIViewController {
    
    let testButton: CustomKeyboardButton = {
        let tb = CustomKeyboardButton()
        return tb
    }()
    
    let keyboardRow: UIStackView = {
        let sv = UIStackView()
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .systemYellow
        sv.axis = .horizontal
        sv.spacing = 0.25
        
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(testButton)
        view.backgroundColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        
        print("Hola desde CKVC")
        configureLayout()
    }
    
}

// MARK: - Layout

extension CustomKeyboardViewController {
    
    private func configureLayout() {
        print("Called configure layout")
        
    }
    
}
