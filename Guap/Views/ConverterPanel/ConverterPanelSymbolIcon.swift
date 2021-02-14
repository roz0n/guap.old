//
//  ConverterPanelSymbolIcon.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/8/21.
//

import UIKit

class ConverterPanelSymbolIcon: UIView {
    
    var countryCode: String?
    
    var symbolLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    convenience init() {
        self.init(for: nil)
    }
    
    init(for country: String?) {
        self.countryCode = country
        super.init(frame: .zero)
        
        self.backgroundColor = K.colors.white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout

extension ConverterPanelSymbolIcon {
    
    private func configureLayout() {
        addSubview(symbolLabel)

        symbolLabel.fillOther(view: self)
        symbolLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        symbolLabel.adjustsFontSizeToFitWidth = true
        symbolLabel.textColor = K.colors.textGray
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: K.widths.panel.symbol),
            self.heightAnchor.constraint(equalToConstant: K.heights.converter.panel),
            
            symbolLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            symbolLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
