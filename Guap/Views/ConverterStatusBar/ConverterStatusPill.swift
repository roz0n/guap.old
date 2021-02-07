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
    
    var textContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textLabel: UILabel?
    
    convenience init() {
        self.init(labelText: nil, labelTextColor: K.colors.black, bgColor: K.colors.white, attributedLabelText: nil)
    }
    
    init(labelText: String?, labelTextColor: UIColor, bgColor: UIColor, attributedLabelText: NSAttributedString?) {
        self.labelText = labelText ?? nil
        self.labelTextColor = labelTextColor
        self.bgColor = bgColor
        self.attributedLabelText = attributedLabelText ?? nil
        
        super.init(frame: .zero)
        
        sizeToFit()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bgColor
        layer.cornerRadius = K.styles.cornerRadius
        layer.masksToBounds = true
        
        configureLabel()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout and configurations

extension ConverterStatusPill {
    
    func configureLabel() {
        textLabel = UILabel()
        
        if let textLabel = textLabel {
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            textLabel.sizeToFit()
            textLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            textLabel.textAlignment = .center
            
            if attributedLabelText != nil {
                textLabel.attributedText = attributedLabelText
            } else if labelText != nil {
                textLabel.text = labelText?.uppercased()
            }
            
            if self.bgColor != K.colors.black {
                textLabel.textColor = K.colors.black
            } else {
                textLabel.textColor = labelTextColor
            }
        }
        
    }
    
    func configureLayout() {
        if let textLabel = textLabel {
            textContainer.addSubview(textLabel)
            textLabel.fillOther(view: textContainer)
        }
        
        addSubview(textContainer)
        
        NSLayoutConstraint.activate([
            textContainer.topAnchor.constraint(equalTo: self.topAnchor),
            textContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            textContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
}
