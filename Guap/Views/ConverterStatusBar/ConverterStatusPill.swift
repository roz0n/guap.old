//
//  ConverterStatusPill.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/6/21.
//

import UIKit

class ConverterStatusPill: UILabel {
    
    var labelText: String?
    var labelTextColor: UIColor
    var bgColor: UIColor
    var attributedLabelText: NSAttributedString?
    
    convenience init() {
        self.init(labelText: nil, labelTextColor: K.colors.black, bgColor: K.colors.white, attributedLabelText: nil)
    }
    
    init(labelText: String?, labelTextColor: UIColor, bgColor: UIColor, attributedLabelText: NSAttributedString?) {
        self.labelText = labelText ?? nil
        self.labelTextColor = labelTextColor
        self.bgColor = bgColor
        self.attributedLabelText = attributedLabelText ?? nil
        
        super.init(frame: .zero)
        
        // TODO: Constants
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bgColor
        layer.cornerRadius = 4
        layer.masksToBounds = true
        lineBreakMode = .byClipping
        
        
        if self.attributedLabelText != nil {
            attributedText = self.attributedLabelText
        } else if labelText != nil {
            text = labelText?.uppercased()
        }
        
        if self.bgColor != K.colors.black {
            textColor = K.colors.black
        } else {
            textColor = labelTextColor
        }
        
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
