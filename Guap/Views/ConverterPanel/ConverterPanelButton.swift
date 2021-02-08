//
//  ConverterPanelButton.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

// TODO: This will need a refactor

class ConverterPanelButton: UIView {
    
    var type: CurrencyType?
    var currencyCode: String?
    var countryCode: String? {
        didSet {
            setFlag(flag: getFlag(for: countryCode!))
        }
    }
    
    let buttonContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = K.colors.headerGray
        view.layer.borderColor = K.colors.borderGray.cgColor
        view.layer.borderWidth = 3
        view.makeCircular()
        
        return view
    }()
    
    var flagLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    convenience init() {
        self.init(for: nil, of: nil, role: nil)
    }
    
    init(for currency: String?, of country: String?, role: CurrencyType?) {
        self.type = role
        self.currencyCode = currency
        self.countryCode = country
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = K.colors.white
        self.widthAnchor.constraint(equalToConstant: K.widths.panel.icon).isActive = true
        
        if let countryCode = countryCode {
            setFlag(flag: getFlag(for: countryCode))
        }
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Helpers

extension ConverterPanelButton {
    
    // Credit: https://stackoverflow.com/questions/30402435
    func getFlag(for country: String) -> String {
        let base: UInt32 = 127397
        var flagCode = ""
        
        // TODO: what's v short for?
        for v in country.uppercased().unicodeScalars {
            flagCode.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        
        return flagCode
    }
    
    func setFlag(flag code: String) {
        flagLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        flagLabel.text = code
    }
    
}

// MARK: - Layout

extension ConverterPanelButton {
    
    private func configureLayout() {
        addSubview(buttonContainer)
        buttonContainer.addSubview(flagLabel)
        flagLabel.fillOther(view: buttonContainer)
        
        NSLayoutConstraint.activate([
            buttonContainer.widthAnchor.constraint(equalToConstant: 45),
            buttonContainer.heightAnchor.constraint(equalToConstant: 45),
            buttonContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            flagLabel.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
            flagLabel.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor)
        ])
    }
    
}
