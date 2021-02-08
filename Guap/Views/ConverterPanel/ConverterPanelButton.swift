//
//  ConverterPanelButton.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

class ConverterPanelButton: UIView {
    
    var type: CurrencyType?
    var currencyCode: String?
    
    let buttonContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = K.colors.headerGray
        view.layer.borderColor = K.colors.borderGray.cgColor
        view.layer.borderWidth = 3
        view.makeCircle()
        
        return view
    }()
    
    convenience init() {
        self.init(for: nil, role: nil)
    }
    
    init(for currency: String?, role: CurrencyType?) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = K.colors.white
        self.widthAnchor.constraint(equalToConstant: K.widths.panel.icon).isActive = true
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout

extension ConverterPanelButton {
    
    func configureLayout() {
        addSubview(buttonContainer)
        
        NSLayoutConstraint.activate([
            buttonContainer.widthAnchor.constraint(equalToConstant: 45),
            buttonContainer.heightAnchor.constraint(equalToConstant: 45),
            buttonContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
}
