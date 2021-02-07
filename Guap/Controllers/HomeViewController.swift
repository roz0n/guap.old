//
//  HomeViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, ConverterControllerDelegate {
    
    // TODO: Move status bar to ConverterController
    let statusBar = ConverterStatusBar()
    
    let converter = ConverterViewController(baseBg: .systemTeal, baseCurr: K.defaults.BaseCurrency, targetBg: .systemPurple, targetCurr: K.defaults.TargetCurrency)
    let converterToolbar = ConverterToolbar()
    let keyboard = CustomKeyboardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        title = K.AppName
        view.backgroundColor = .white
        
        converter.delegate = self
        configureBarButtons()
        configureLayout()
        configureGestures()
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

// MARK: - ConverterControllerDelegate methods

extension HomeViewController {
    
    func didGetPairConversion(_ sender: ConverterViewController?, responseData: ERPairConversionModel, result: Double?) {
        DispatchQueue.main.async { [weak self] in
            if let result = result {
                self?.converter.targetValueField.text = String(result)
            }
        }
    }
    
}

// MARK: - Gesture handlers

extension HomeViewController {
    
    func configureGestures() {
        configureConvertGesture()
        configureResetGesture()
    }
    
    func configureConvertGesture() {
        let convertTap = UITapGestureRecognizer(target: self, action: #selector(convertButtonTapped))
        converterToolbar.convertButton.addGestureRecognizer(convertTap)
    }
    
    func configureResetGesture() {
        let resetTap = UITapGestureRecognizer(target: self, action: #selector(resetButtonTapped))
        converterToolbar.resetButton.addGestureRecognizer(resetTap)
    }
    
    @objc func convertButtonTapped(_ sender: UITapGestureRecognizer) {
        converter.getPairedConversionData()
    }
    
    @objc func resetButtonTapped(_ sender: UITapGestureRecognizer) {
        converter.resetValues()
    }
    
}

// MARK: - Layout

extension HomeViewController {
    
    private func configureLayout() {
        // TODO: As stated above, statusBar needs to be moved to ConverterController
        // Same with converter toolBar, this VC only needs to handle laying out the converter and keyboard
        view.addSubview(statusBar)
        
        view.addSubview(converter.view)
//        view.addSubview(converterToolbar)
//        view.addSubview(keyboard.view)
        
        NSLayoutConstraint.activate([
            statusBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: K.heights.converter.statusBar),
            
            converter.view.topAnchor.constraint(equalTo: statusBar.bottomAnchor),
            converter.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            converter.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            converter.view.heightAnchor.constraint(equalToConstant: K.heights.converter.container),
            
//            converterToolbar.topAnchor.constraint(equalTo: converter.view.bottomAnchor),
//            converterToolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            converterToolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            converterToolbar.heightAnchor.constraint(equalToConstant: K.heights.converter.toolbar),
//
//            keyboard.view.topAnchor.constraint(equalTo: converterToolbar.bottomAnchor),
//            keyboard.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            keyboard.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            keyboard.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
