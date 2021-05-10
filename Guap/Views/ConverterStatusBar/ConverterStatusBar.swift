//
//  ConverterStatusBar.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/4/21.
//

import UIKit

// TODO: Constants
class ConverterStatusBar: UIView {
    
    var currencyPill: ConverterStatusPill?
    var datePill: ConverterStatusPill?
    var ratePill: ConverterStatusPill?
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
        createPills()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Pills

extension ConverterStatusBar {
    
    // TODO: Constants
    
    private func createPills() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 13, weight: .bold)
        
        createCurrencyPill(with: symbolConfiguration)
        createDatePill()
        createRatePill(with: symbolConfiguration)
    }
    
    private func createCurrencyPill(with configuration: UIImage.SymbolConfiguration?) {
        let textAttachment = NSTextAttachment()
        let textImage = UIImage(systemName: "arrow.forward", withConfiguration: configuration)?.withTintColor(K.colors.white, renderingMode: .alwaysTemplate)
        let labelText = NSMutableAttributedString(string: "EUR ")
        
        textAttachment.image = textImage
        labelText.append(NSAttributedString(attachment: textAttachment))
        labelText.append(NSAttributedString(string: " DOP"))
        
        currencyPill = ConverterStatusPill(labelText: nil, labelTextColor: K.colors.white, bgColor: K.colors.black, attributedLabelText: labelText)
        currencyPill?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func convertDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E. d MMM yyyy"
        
        let convertedDate = dateFormatter.string(from: date)
        return convertedDate.description
        
    }
    
    private func getFormattedDate() -> String {
        let now = Date()
        let convertedDate = convertDate(date: now)
        return convertedDate
    }
    
    private func createDatePill() {
        let today = getFormattedDate()
        datePill = ConverterStatusPill(labelText: today, labelTextColor: K.colors.white, bgColor: K.colors.white, attributedLabelText: nil)
        datePill?.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private func createRatePill(with configuration: UIImage.SymbolConfiguration?) {
        let textAttachment = NSTextAttachment()
        let textImage = UIImage(systemName: "arrow.up.right", withConfiguration: configuration)?.withTintColor(K.colors.black, renderingMode: .alwaysTemplate)
        let labelText = NSMutableAttributedString(attachment: textAttachment)
       
        textAttachment.image = textImage
        labelText.append(NSAttributedString(string: conversionRate ?? "  70.265"))
        
        ratePill = ConverterStatusPill(labelText: nil, labelTextColor: K.colors.white, bgColor: K.colors.green, attributedLabelText: labelText)
        ratePill?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    // TODO: Make this work
    func updateConversionRateLabel(to value: Float) {
        if let pill = ratePill {
            pill.labelText = String(value)
        }
    }
    
}

// MARK: - Layout

extension ConverterStatusBar {
    
    private func configureLayout() {
        addSubview(stack)
        
        if let cp = currencyPill, let dp = datePill, let rp = ratePill {
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
