//
//  ConverterPanelField.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

class ConverterPanelField: UIView {
    
    var amountLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedSystemFont(ofSize: 32, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.lineBreakMode = .byTruncatingMiddle
        label.text = ""
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = K.colors.white
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout

extension ConverterPanelField {
    
    private func configureLayout() {
        addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: K.spacers.panels.fields.leading),
            amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            amountLabel.topAnchor.constraint(equalTo: self.topAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
