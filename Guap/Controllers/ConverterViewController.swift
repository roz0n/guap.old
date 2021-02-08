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
    
    let baseValuePanel = ConverterPanel()
    let baseValueSymbol = ConverterPanelSymbolIcon()
    let baseValueButton = ConverterPanelButton()
    let baseValueField = ConverterPanelTextField()
    var baseValue: Int?
    
    let targetValuePanel = ConverterPanel()
    let targetValueSymbol = ConverterPanelSymbolIcon()
    let targetValueButton = ConverterPanelButton()
    let targetValueField = ConverterPanelTextField()
    
    let toolbar = ConverterToolbar()
    
    private let panelStack: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.axis = .vertical
        view.distribution = .fillEqually
        
        return view
    }()
    
    init(baseBg baseBackground: UIColor, baseCurr baseCurrency: String, targetBg targetBackground: UIColor, targetCurr targetCurrency: String) {
        super.init(nibName: nil, bundle: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        baseValuePanel.bgColor = baseBackground
        baseValueButton.currencyCode = baseCurrency
        baseValueButton.type = .Base
        baseValueButton.countryCode = "EU"
        baseValueField.isEnabled = false
        
        targetValuePanel.bgColor = targetBackground
        targetValueButton.currencyCode = targetCurrency
        targetValueButton.type = .Target
        targetValueButton.countryCode = "DO"
        targetValueField.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureGestures()
    }
    
    func calculatePair(base: Double, rate: Double) -> Double {
        return (base * rate).rounded()
    }
    
    func resetValues() {
        baseValue = nil
        baseValueField.text = ""
        targetValueField.text = ""
    }
    
}

// MARK: - Data fetching

extension ConverterViewController {
    
    func getPairedConversionData() {
        guard let base = baseValue else { return }
        
        baseValueField.isEnabled.toggle()
        
        DispatchQueue.global().async {
            ERDataManager.shared.getPairConversion(base: K.defaults.BaseCurrency, target: K.defaults.TargetCurrency) { [weak self] (response, error) in
                if error != nil {
                    print("Error: \(String(describing: error))")
                    return
                }
                
                if let response = response {
                    let conversionResult = self?.calculatePair(base: Double(base), rate: response.conversionRate)
                    self?.delegate?.didGetPairConversion(self, responseData: response, result: conversionResult)
                }
            }
        }
        
        baseValueField.isEnabled.toggle()
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
            
            vc.modalPresentationStyle = .pageSheet
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func convertButtonTapped(_ sender: UITapGestureRecognizer) {
        //        self.getPairedConversionData()
        print("Tapped convert")
    }
    
    @objc func swapButtonTapped(_ sender: UITapGestureRecognizer) {
        //        self.resetValues()
        print("Tapped swap")
    }
    
    @objc func shareButtonTapped(_ sender: UITapGestureRecognizer) {
        //        self.resetValues()
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
        converterBase = ConverterPanelUIModel(panel: baseValuePanel, symbol: baseValueSymbol, button: baseValueButton, field: baseValueField)
        converterTarget = ConverterPanelUIModel(panel: targetValuePanel, symbol: targetValueSymbol, button: targetValueButton, field: targetValueField)
    }
    
    private func configurePanels() {
        allPanels = [converterBase!, converterTarget!]
        
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
        ])
    }
    
}
