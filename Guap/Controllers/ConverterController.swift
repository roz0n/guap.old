//
//  ConverterController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

protocol ConverterControllerDelegate {
    func didGetPairConversion(_ sender: ConverterController?, responseData: ERPairConversionModel, result: Double?)
}

class ConverterController: UIViewController, UITextFieldDelegate {
    
    var delegate: ConverterControllerDelegate?
    
    var allPanels = [ConverterPanelUIModel]()
    var converterBase: ConverterPanelUIModel?
    var converterTarget: ConverterPanelUIModel?
    
    let baseValuePanel = ConverterPanel()
    let baseValueButton = ConverterPanelButton()
    let baseValueField = ConverterPanelTextField()
    var baseValue: Int?
    
    let targetValuePanel = ConverterPanel()
    let targetValueButton = ConverterPanelButton()
    let targetValueField = ConverterPanelTextField()
    
    private let panelStack: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 0.25
        
        return view
    }()
    
    init(baseBg baseBackground: UIColor, baseCurr baseCurrency: String, targetBg targetBackground: UIColor, targetCurr targetCurrency: String) {
        super.init(nibName: nil, bundle: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        baseValuePanel.bgColor = baseBackground
        baseValueButton.title = baseCurrency
        baseValueField.delegate = self
        baseValueField.tag = 0
        
        targetValuePanel.bgColor = targetBackground
        targetValueButton.title = targetCurrency
        targetValueField.isEnabled = false
        targetValueField.layer.backgroundColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        targetValueField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
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

// MARK: - Data fetching methods

extension ConverterController {
    
    func getPairedConversionData() {
        guard let base = baseValue else { return }
        
        baseValueField.isEnabled.toggle()
        
        DispatchQueue.global().async {
            ERDataManager.shared.getPairConversion(base: C.defaults.BaseCurrency, target: C.defaults.TargetCurrency) { [weak self] (response, error) in
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

// MARK: - Text field methods

extension ConverterController {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if reason == .committed {
            if let text = textField.text, textField.tag == 0 {
                baseValue = Int(text)
            }
        }
    }
    
}

// MARK: - Gesture handlers

extension ConverterController {
    
    func setGestures() {
        setKeyboardDismissGesture()
    }
    
    func setKeyboardDismissGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - Layout

/**
 This extension handles adding each "panel" (or row) containing the various UI elements that compose the greater currency converter UI component.
 First, it creates a data structure that contains the aforementioned UI elements and adds them to homogeneous array. Later, this makes adding constraints trivial and far less repetitive.
 Second, it adds each panel to the UIStackView defied at the top of the class. Third, it lays out each panel's UI elements dynamically within a loop.
 Finally, it applies basic constraints to the panelStack view itself. Each method is called sequentially by the `configureLayout` method in `viewDidLoad` in an effort to keep their usage contained to the extension.
 */

extension ConverterController {
    
    private func configureLayout() {
        self.setGestures()
        self.preparePanels()
        self.configurePanels()
        self.configureStackView()
    }
    
    private func preparePanels() {
        converterBase = ConverterPanelUIModel(panel: baseValuePanel, button: baseValueButton, field: baseValueField)
        converterTarget = ConverterPanelUIModel(panel: targetValuePanel, button: targetValueButton, field: targetValueField)
    }
    
    private func configurePanels() {
        allPanels = [converterBase!, converterTarget!]
        
        guard !allPanels.isEmpty else { return }
        
        for converterPanel in allPanels {
            panelStack.addArrangedSubview(converterPanel.panel!)
            
            if let panel = converterPanel.panel, let button = converterPanel.button, let field = converterPanel.field {
                panel.addSubview(button)
                panel.addSubview(field)
                
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: panel.topAnchor, constant: 10),
                    button.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -10),
                    field.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 10),
                    field.centerXAnchor.constraint(equalTo: panel.centerXAnchor),
                    field.centerYAnchor.constraint(equalTo: panel.centerYAnchor)
                ])
            }
        }
    }
    
    private func configureStackView() {
        view.addSubview(panelStack)
        panelStack.fillOther(view: self.view)
    }
    
}
