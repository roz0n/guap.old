//
//  HomeViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, ConverterControllerDelegate, CustomKeyboardDelegate {
    
    let converter = ConverterViewController(base: K.defaults.BaseCurrency, target: K.defaults.TargetCurrency)
    let keyboard = CustomKeyboardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.colors.white
        
        converter.delegate = self
        keyboard.delegate = self
        
        configureLogo()
        configureBarButtons()
        configureLayout()
    }
    
    func configureLogo() {
        let logo = UIImage(named: "Logotype.png")
        let imageView = UIImageView(image: logo)
        
        navigationItem.titleView = imageView
    }
    
    func configureBarButtons() {
        let settingsIcon = UIImage(systemName: K.icons.HomeSettings)
        let historyIcon = UIImage(systemName: K.icons.HomeHistory)
        
        let settingsButton = UIBarButtonItem(image: settingsIcon, style: .plain, target: self, action: #selector(settingsButtonTapped))
        let historyButton = UIBarButtonItem(image: historyIcon, style: .plain, target: self, action: #selector(historyButtonTapped))
        
        navigationItem.rightBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem?.tintColor = K.colors.black
        
        navigationItem.leftBarButtonItem = historyButton
        navigationItem.leftBarButtonItem?.tintColor = K.colors.black
    }
    
}

// MARK: - ConverterControllerDelegate

extension HomeViewController {
    
    func didGetPairConversion(_ sender: ConverterViewController?, responseData: ERPairConversionModel, result: Float?) {
        DispatchQueue.main.async { [weak self] in
            if let result = result {
                self?.converter.targetField.amountLabel.text = ConverterHelperService.shared.formatFloatAsCurrency(result, to: nil)
                self?.converter.statusBar.updateConversionRateLabel(to: result)
            }
        }
    }
    
}

// MARK: - CustomKeyboardDelegate

extension HomeViewController {
    
    func keyboardButtonWasTapped(_ sender: CustomKeyboardViewController, button: CustomKeyboardButton) {
        // TODO: There's a ton of behaviors here that we'll have to sort out.
        
        let value = button.keyValue
        
        switch value {
            case "de":
                converter.baseField.amountLabel.text! += "."
            case "dl":
                if converter.targetField.amountLabel.text != nil {
                    converter.targetField.amountLabel.text! =  ""
                }
                
                converter.baseField.amountLabel.text! = String(converter.baseField.amountLabel.text!.dropLast())
            default:
                if #available(iOS 10.0, *) {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
                
                converter.baseField.amountLabel.text! += String(value)
        }
    }
    
}

// MARK: - Gestures

extension HomeViewController {
    
    @objc func settingsButtonTapped() {
        let vc = SettingsViewController()
        
        vc.navigationItem.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func historyButtonTapped() {
        let vc = HistoryViewController()
        
        vc.navigationItem.title = "History"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

// MARK: - Layout

extension HomeViewController {
    
    private func configureLayout() {
        view.addSubview(converter.view)
        view.addSubview(keyboard.view)
        
        NSLayoutConstraint.activate([
            converter.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            converter.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            converter.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            keyboard.view.topAnchor.constraint(equalTo: converter.view.bottomAnchor),
            keyboard.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            keyboard.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            keyboard.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
