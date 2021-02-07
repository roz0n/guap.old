//
//  ConverterStatusBar.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

class ConverterStatusBar: UIView {
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = K.colors.white
        
        // TODO: Why isn't this working?
        addBorder(borders: [.Bottom], color: K.colors.red, width: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
