//
//  ConverterController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

protocol ConverterControllerDelegate {
    func didGetPairConversion(_ sender: ConverterController?, data: ERPairConversionModel)
}

class ConverterController: UIViewController, UITextFieldDelegate {
    
    var delegate: ConverterControllerDelegate?
    
    var allPanels = [ConverterPanelUIModel]()
    var converterInput: ConverterPanelUIModel?
    var converterOutput: ConverterPanelUIModel?
    
    let inputPanel = ConverterPanel()
    let inputButton = ConverterPanelButton()
    let inputField = ConverterPanelTextField()
    
    let outputPanel = ConverterPanel()
    let outputButton = ConverterPanelButton()
    let outputField = ConverterPanelTextField()
    
    private let panelStack: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 0.25
        
        return view
    }()
    
    init(inputBackground: UIColor, outputBackground: UIColor, inputCurrency: String, outputCurrency: String) {
        super.init(nibName: nil, bundle: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        inputPanel.bgColor = inputBackground
        inputButton.title = inputCurrency
        inputField.delegate = self
        inputField.tag = 0
        
        outputPanel.bgColor = outputBackground
        outputButton.title = outputCurrency
        outputField.delegate = self
        outputField.tag = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
}

// MARK: - Data fetching methods

extension ConverterController {
    
    func getPairedConversionData() {
        DispatchQueue.global().async {
            ERDataManager.shared.getPairConversion(input: "EUR", output: "DOP") { [weak self] (response, error) in
                if error != nil {
                    print("Error: \(String(describing: error))")
                    return
                }
                
                if let response = response {
                    self?.delegate?.didGetPairConversion(self, data: response)
                }
            }
        }
    }
    
}

// MARK: - Text field methods

extension ConverterController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
            case 0:
                print("Input field typing...")
            case 1:
                print("Output field typing...")
            default:
                print("Error checking input field tag")
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
        converterInput = ConverterPanelUIModel(panel: inputPanel, button: inputButton, field: inputField)
        converterOutput = ConverterPanelUIModel(panel: outputPanel, button: outputButton, field: outputField)
    }
    
    private func configurePanels() {
        allPanels = [converterInput!, converterOutput!]
        
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
