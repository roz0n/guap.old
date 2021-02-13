//
//  ConverterViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

// TODO: This could be named better
enum CurrencyType: String {
    case Base = "base"
    case Target = "target"
}

protocol ConverterControllerDelegate {
    func didGetPairConversion(_ sender: ConverterViewController?, responseData: ERPairConversionModel, result: Double?)
}

class ConverterViewController: UIViewController {
    
    var delegate: ConverterControllerDelegate? 
    let statusBar = ConverterStatusBar()
    
    var allPanels = [ConverterPanelUIModel]()
    var converterBase: ConverterPanelUIModel?
    var converterTarget: ConverterPanelUIModel?
    
    let basePanel = ConverterPanel()
    let baseSymbol = ConverterPanelSymbolIcon()
    let baseButton = ConverterPanelButton()
    let baseField = ConverterPanelField()
    
    let targetPanel = ConverterPanel()
    let targetSymbol = ConverterPanelSymbolIcon()
    let targetButton = ConverterPanelButton()
    let targetField = ConverterPanelField()
    
    let toolbar = ConverterToolbar()
    
    var baseValue: Double?
    var targetValue: Double?
    var conversionRate: Double? {
        didSet {
            statusBar.conversionRate = String(conversionRate!)
        }
    }
    
    private let panelStack: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.axis = .vertical
        view.distribution = .fillEqually
        
        return view
    }()
    
    init(base baseCurrency: String, target targetCurrency: String) {
        super.init(nibName: nil, bundle: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        baseButton.currencyCode = baseCurrency
        baseButton.type = .Base
        baseButton.countryCode = "EU"
        
        targetButton.currencyCode = targetCurrency
        targetButton.type = .Target
        targetButton.countryCode = "DO"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureGestures()
    }
    
    func formatBaseValue() {
        // Obtain the base field's text
        // Convert it to a Double
        // Set the result of that conversion to the baseValue variable
        // Set the fieldValue label to the value of double in case it's not already (this might be removed once we format currency correctly
        let baseFieldText = baseField.amountLabel.text
        
        if let stringValue = baseFieldText {
            if let rawValue = Double(stringValue) {
                baseValue = rawValue
                
                if let currencyFormattedValue = formatCurrency(rawValue) {
                    baseField.amountLabel.text! = currencyFormattedValue
                } else {
                    baseField.amountLabel.text! = String(rawValue)
                }
            }
        }
    }
    
    func formatCurrency(_ value: Double) -> String? {
        let formatter = NumberFormatter()
        // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        // https://stackoverflow.com/questions/41558832/how-to-format-a-double-into-currency-swift-3
        // formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        
        return formatter.string(from: value as NSNumber)
    }
    
    func calculatePair(base: Double, rate: Double) -> Double {
        return (base * rate).rounded()
    }
    
}

// MARK: - Data

extension ConverterViewController {
    
    func getPairedConversionData() {
        formatBaseValue()
        
        guard let base = baseValue else { return }
        
        DispatchQueue.global().async {
            ERDataService.shared.getPairConversion(base: K.defaults.BaseCurrency, target: K.defaults.TargetCurrency) { [weak self] (response, error) in
                if error != nil {
                    print("Error: \(String(describing: error))")
                    return
                }
                
                if let response = response {
                    // TODO: Should we be setting all the internal properties here?
                    self?.conversionRate = response.conversionRate
                    
                    let conversionResult = self?.calculatePair(base: Double(base), rate: response.conversionRate)
                    self?.delegate?.didGetPairConversion(self, responseData: response, result: conversionResult)
                }
            }
        }
    }
    
}

// MARK: - Gestures

extension ConverterViewController {
    
    func configureGestures() {
        configureCurrencySelectionGesture()
        configureConvertGesture()
        configureSwapGesture()
        configureShareGesture()
    }
    
    func configureCurrencySelectionGesture() {
        for panel in allPanels {
            let tap = UITapGestureRecognizer(target: self, action: #selector(openCurrencySelectionScreen))
            
            if let button = panel.button {
                button.addGestureRecognizer(tap)
            }
        }
    }
    
    func configureConvertGesture() {
        let convertTap = UITapGestureRecognizer(target: self, action: #selector(convertButtonTapped))
        toolbar.convertButton.addGestureRecognizer(convertTap)
    }
    
    func configureSwapGesture() {
        let swapTap = UITapGestureRecognizer(target: self, action: #selector(swapButtonTapped))
        toolbar.swapButton.addGestureRecognizer(swapTap)
    }
    
    func configureShareGesture() {
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(shareButtonTapped))
        toolbar.shareButton.addGestureRecognizer(shareTap)
    }
    
    @objc func openCurrencySelectionScreen(_ sender: UITapGestureRecognizer) {
        let button = sender.view as? ConverterPanelButton
        let type = button?.type
        
        if let type = type {
            let vc = UINavigationController(rootViewController: CurrencySelectorViewController(type: type))
            let backButtonIcon = UIImage(systemName: "xmark")
            
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonIcon, style: .plain, target: nil, action: nil)
            vc.modalPresentationStyle = .pageSheet
            
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func convertButtonTapped(_ sender: UITapGestureRecognizer) {
        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
        
        getPairedConversionData()
    }
    
    @objc func swapButtonTapped(_ sender: UITapGestureRecognizer) {
        print("Tapped swap")
    }
    
    @objc func shareButtonTapped(_ sender: UITapGestureRecognizer) {
        print("Tapped share")
    }
    
}

// MARK: - Layout

extension ConverterViewController {
    
    private func configureLayout() {
        createPanels()
        configurePanels()
        configureSubviews()
    }
    
    private func createPanels() {
        converterBase = ConverterPanelUIModel(panel: basePanel, symbol: baseSymbol, button: baseButton, field: baseField)
        converterTarget = ConverterPanelUIModel(panel: targetPanel, symbol: targetSymbol, button: targetButton, field: targetField)
        
        if let cb = converterBase, let ct = converterTarget {
            allPanels = [cb, ct]
        }
    }
    
    private func configurePanels() {
        guard !allPanels.isEmpty else { return }
        
        for converterPanel in allPanels {
            panelStack.addArrangedSubview(converterPanel.panel!)
            
            if let panel = converterPanel.panel, let icon = converterPanel.symbol, let button = converterPanel.button, let field = converterPanel.field {
                panel.stack.addArrangedSubview(icon)
                panel.stack.addArrangedSubview(field)
                panel.stack.addArrangedSubview(button)
            }
        }
    }
    
    private func configureSubviews() {
        view.addSubview(statusBar)
        view.addSubview(panelStack)
        view.addSubview(toolbar)
        
        NSLayoutConstraint.activate([
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: K.heights.converter.statusBar),
            
            panelStack.topAnchor.constraint(equalTo: statusBar.bottomAnchor),
            panelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            panelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            panelStack.heightAnchor.constraint(equalToConstant: (K.heights.converter.panel * CGFloat(allPanels.count))),
            
            toolbar.topAnchor.constraint(equalTo: panelStack.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: K.heights.converter.toolbar),
            
            view.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor)
        ])
    }
    
}
