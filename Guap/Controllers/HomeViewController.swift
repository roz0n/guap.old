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
    
    let converter = ConverterController(baseBg: .systemTeal, baseCurr: C.defaults.BaseCurrency, targetBg: .systemPurple, targetCurr: C.defaults.TargetCurrency)
    let converterToolbar = ConverterToolbar()
    let keyboard = CustomKeyboardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        title = C.AppName
        view.backgroundColor = .white
        
        converter.delegate = self
        configureBarButtons()
        configureLayout()
        configureGestures()
    }
    
    func configureBarButtons() {
        let settingsIcon = UIImage(systemName: C.icons.HomeSettings)
        let historyIcon = UIImage(systemName: C.icons.HomeHistory)
        
        let settingsButton = UIBarButtonItem(image: settingsIcon, style: .plain, target: nil, action: nil)
        let historyButton = UIBarButtonItem(image: historyIcon, style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = settingsButton
        navigationItem.leftBarButtonItem = historyButton
    }
    
}

// MARK: - ConverterControllerDelegate methods

extension HomeViewController {
    
    func didGetPairConversion(_ sender: ConverterController?, responseData: ERPairConversionModel, result: Double?) {
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
        view.addSubview(statusBar)
        
        view.addSubview(converter.view)
        view.addSubview(converterToolbar)
        view.addSubview(keyboard.view)
        
        NSLayoutConstraint.activate([
            statusBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: C.heights.converter.statusBar),
            
            converter.view.topAnchor.constraint(equalTo: statusBar.bottomAnchor),
            converter.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            converter.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            converter.view.heightAnchor.constraint(equalToConstant: C.heights.converter.container),
            
            converterToolbar.topAnchor.constraint(equalTo: converter.view.bottomAnchor),
            converterToolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            converterToolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            converterToolbar.heightAnchor.constraint(equalToConstant: C.heights.converter.toolbar),
            
            keyboard.view.topAnchor.constraint(equalTo: converterToolbar.bottomAnchor),
            keyboard.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            keyboard.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            keyboard.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
