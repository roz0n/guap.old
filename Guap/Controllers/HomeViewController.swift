//
//  HomeViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, ConverterControllerDelegate {
    
    let converter = ConverterViewController(baseBg: .systemTeal, baseCurr: K.defaults.BaseCurrency, targetBg: .systemPurple, targetCurr: K.defaults.TargetCurrency)
    let keyboard = CustomKeyboardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.colors.white
        converter.delegate = self
        
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
        
        let settingsButton = UIBarButtonItem(image: settingsIcon, style: .plain, target: nil, action: nil)
        let historyButton = UIBarButtonItem(image: historyIcon, style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem?.tintColor = K.colors.black
        
        navigationItem.leftBarButtonItem = historyButton
        navigationItem.leftBarButtonItem?.tintColor = K.colors.black
    }
    
}

// MARK: - ConverterControllerDelegate

extension HomeViewController {
    
    func didGetPairConversion(_ sender: ConverterViewController?, responseData: ERPairConversionModel, result: Double?) {
        DispatchQueue.main.async { [weak self] in
            if let result = result {
                self?.converter.targetValueField.text = String(result)
            }
        }
    }
    
}

// MARK: - Layout

extension HomeViewController {
    
    private func configureLayout() {
        view.addSubview(converter.view)
        
        NSLayoutConstraint.activate([
            converter.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            converter.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            converter.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            converter.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
            //            keyboard.view.topAnchor.constraint(equalTo: converterToolbar.bottomAnchor),
            //            keyboard.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            //            keyboard.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            //            keyboard.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
