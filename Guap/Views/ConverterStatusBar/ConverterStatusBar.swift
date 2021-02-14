//
//  ConverterStatusBar.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

// TODO: Constants
class ConverterStatusBar: UIView {
    
    var currencyChip: ConverterStatusChip?
    var dateChip: ConverterStatusChip?
    var rateChip: ConverterStatusChip?
    var conversionRate: String?
    
    let stack: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20)
        stack.axis = .horizontal
        stack.spacing = 10
        
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = K.colors.white
        
        addBorder(borders: [.Bottom], color: K.colors.borderGray, width: 0.5)
        createChips()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Chips

extension ConverterStatusBar {
    
    // TODO: Constants
    
    private func createChips() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 13, weight: .bold)
        
        createCurrencyChip(with: symbolConfiguration)
        createDateChip()
        createRateChip(with: symbolConfiguration)
    }
    
    private func createCurrencyChip(with configuration: UIImage.SymbolConfiguration?) {
        let textAttachment = NSTextAttachment()
        let textImage = UIImage(systemName: "arrow.forward", withConfiguration: configuration)?.withTintColor(K.colors.white, renderingMode: .alwaysTemplate)
        let labelText = NSMutableAttributedString(string: "EUR ")
        
        textAttachment.image = textImage
        labelText.append(NSAttributedString(attachment: textAttachment))
        labelText.append(NSAttributedString(string: " DOP"))
        
        currencyChip = ConverterStatusChip(labelText: nil, labelTextColor: K.colors.white, bgColor: K.colors.black, attributedLabelText: labelText)
        currencyChip?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func createDateChip() {
        dateChip = ConverterStatusChip(labelText: "Thu. 2 Feb 2021", labelTextColor: K.colors.white, bgColor: K.colors.white, attributedLabelText: nil)
        dateChip?.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private func createRateChip(with configuration: UIImage.SymbolConfiguration?) {
        let textAttachment = NSTextAttachment()
        let textImage = UIImage(systemName: "arrow.up.right", withConfiguration: configuration)?.withTintColor(K.colors.black, renderingMode: .alwaysTemplate)
        let labelText = NSMutableAttributedString(attachment: textAttachment)
       
        textAttachment.image = textImage
        labelText.append(NSAttributedString(string: conversionRate ?? "  70.265"))
        
        rateChip = ConverterStatusChip(labelText: nil, labelTextColor: K.colors.white, bgColor: K.colors.green, attributedLabelText: labelText)
        rateChip?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    // TODO: Make this work
    func updateConversionRateLabel(to value: Float) {
        if let chip = rateChip {
            chip.labelText = String(value)
        }
    }
    
}

// MARK: - Layout

extension ConverterStatusBar {
    
    private func configureLayout() {
        addSubview(stack)
        
        if let cp = currencyChip, let dp = dateChip, let rp = rateChip {
            stack.addArrangedSubview(cp)
            stack.addArrangedSubview(dp)
            stack.addArrangedSubview(rp)
        }
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}
