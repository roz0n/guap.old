//
//  ConverterStatusPill.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/6/21.
//

import UIKit

class ConverterStatusPill: UILabel {
    
    var labelText: String
    var labelTextColor: UIColor
    var bgColor: UIColor
    
    init(labelText: String, labelTextColor: UIColor, bgColor: UIColor) {
        self.labelText = labelText
        self.labelTextColor = labelTextColor
        self.bgColor = bgColor
        
        super.init(frame: .zero)
        
        // TODO: Constants
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bgColor
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        text = labelText.uppercased()
        textColor = labelTextColor
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
    
}
