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
        axis = .horizontal
        distribution = .fillEqually
        spacing = K.spacers.keyboard.leading
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
