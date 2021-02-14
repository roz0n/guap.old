//
//  ConverterViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

enum CurrencyInputType: String {
    case Base = "base"
    case Target = "target"
}

class ConverterViewController: UIViewController {
    
    let statusBar = ConverterStatusBar()
    let toolbar = ConverterToolbar()
    
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
    
    var conversionRate: Float? {
        didSet {
            //            statusBar.conversionRate = String(conversionRate!)
            print("Set conversion rate!", conversionRate)
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
        
        updatePanelCurrencyLabels()
        configureLayout()
        configureGestures()
    }
    
    func resetPanelFieldLabels() {
        baseField.amountLabel.text = ""
        targetField.amountLabel.text = ""
    }
    
    func updatePanelFieldLabels(with response: ERPairConversionModel) {
        // TODO: Loop over all panels to reduce repetition
        DispatchQueue.main.async { [weak self] in
            let baseFieldText = self?.baseField.amountLabel.text!
            guard let baseValue = Float(baseFieldText!) else { return }
            
            let conversionResult = ConverterHelperService.shared.convertPair(base: baseValue, rate: response.conversionRate)
            let formattedBaseValue = ConverterHelperService.shared.formatFloatAsCurrency(baseValue, to: ConverterHelperService.shared.getLocaleFromCurrencyCode(K.defaults.BaseCurrency))
            let formattedTargetValue = ConverterHelperService.shared.formatFloatAsCurrency(conversionResult, to: ConverterHelperService.shared.getLocaleFromCurrencyCode(K.defaults.TargetCurrency))
            
            self?.baseField.amountLabel.text = formattedBaseValue?.replacingOccurrences(of: ConverterHelperService.currencyStringToNumsPattern, with: "", options: .regularExpression)
            self?.targetField.amountLabel.text = formattedTargetValue?.replacingOccurrences(of: ConverterHelperService.currencyStringToNumsPattern, with: "", options: .regularExpression)
            self?.conversionRate = response.conversionRate
        }
    }
    
    func updatePanelCurrencyLabels() {
        // TODO: Loop over all panels to reduce repetition
        DispatchQueue.main.async { [weak self] in
            let baseSymbolValue = ConverterHelperService.shared.getLocaleFromCurrencyCode(K.defaults.BaseCurrency)
            let targetSymbolValue = ConverterHelperService.shared.getLocaleFromCurrencyCode(K.defaults.TargetCurrency)
            
            if let newBaseSymbol = baseSymbolValue?.currencySymbol {
                self?.baseSymbol.symbolLabel.text = newBaseSymbol
                
                if (newBaseSymbol.count > 1) {
                    self?.baseSymbol.symbolLabel.textAlignment = .right
                    self?.baseSymbol.symbolLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                } else {
                    self?.baseSymbol.symbolLabel.textAlignment = .center
                }
            }
            
            if let newTargetSymbol = targetSymbolValue?.currencySymbol {
                self?.targetSymbol.symbolLabel.text = newTargetSymbol
                
                if (newTargetSymbol.count > 1) {
                    self?.targetSymbol.symbolLabel.textAlignment = .right
                    self?.targetSymbol.symbolLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                } else {
                    self?.targetSymbol.symbolLabel.textAlignment = .center
                }
            }
        }
    }
    
}

// MARK: - Data

extension ConverterViewController {
    
    func getPairedConversionData() {
        DispatchQueue.global().async {
            ERDataService.shared.getPairConversion(base: K.defaults.BaseCurrency, target: K.defaults.TargetCurrency) { [weak self] (response, error) in
                if error != nil { print("Error: \(String(describing: error))"); return }
                
                if let response = response {
                    self?.updatePanelFieldLabels(with: response)
                    self?.updatePanelCurrencyLabels()
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
        configureClearGesture()
        configureSwapGesture()
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
    
    func configureClearGesture() {
        let clearTap = UITapGestureRecognizer(target: self, action: #selector(clearButtonTapped))
        toolbar.clearButton.addGestureRecognizer(clearTap)
    }
    
    func configureSwapGesture() {
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(swapButtonTapped))
        toolbar.swapButton.addGestureRecognizer(shareTap)
    }
    
    @objc func openCurrencySelectionScreen(_ sender: UITapGestureRecognizer) {
        let button = sender.view as? ConverterPanelButton
        let type = button?.type
        
        if let type = type {
            let vc = UINavigationController(rootViewController: CurrencySelectorViewController(type: type))
            vc.modalPresentationStyle = .overFullScreen
            
            if let root = getRootViewController(of: self) {
                root.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @objc func convertButtonTapped(_ sender: UITapGestureRecognizer) {
        if #available(iOS 10.0, *) { UIImpactFeedbackGenerator(style: .heavy).impactOccurred() }
        getPairedConversionData()
    }
    
    @objc func clearButtonTapped(_ sender: UITapGestureRecognizer) {
        if #available(iOS 10.0, *) { UIImpactFeedbackGenerator(style: .rigid).impactOccurred() }
        resetPanelFieldLabels()
    }
    
    @objc func swapButtonTapped(_ sender: UITapGestureRecognizer) {
        print("Tapped swap")
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
