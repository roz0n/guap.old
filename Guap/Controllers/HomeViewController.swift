//
//  HomeViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, ConverterControllerDelegate {
    
    let converter = ConverterController(inputBackground: .systemTeal, outputBackground: .systemPurple, inputCurrency: "EUR", outputCurrency: "DOP")
    let converterToolbar = ConverterToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        title = "Guap"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        converter.delegate = self
        configureBarButtons()
        configureLayout()
        configureGestures()
    }
    
    func configureBarButtons() {
        let settingsIcon = UIImage(systemName: "gearshape.2.fill")
        let settingsButton = UIBarButtonItem(image: settingsIcon, style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = settingsButton
    }
    
}

// MARK: - ConverterControllerDelegate methods

extension HomeViewController {
    
    func didGetPairConversion(_ sender: ConverterController?, responseData: ERPairConversionModel, result: Double?) {
        DispatchQueue.main.async { [weak self] in
            if let result = result {
                self?.converter.outputField.text = String(result)
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
        let convertTap = UITapGestureRecognizer(target: self, action: #selector(convertButtonPressed))
        converterToolbar.convertButton.addGestureRecognizer(convertTap)
    }
    
    func configureResetGesture() {
        let resetTap = UITapGestureRecognizer(target: self, action: #selector(resetButtonPressed))
        converterToolbar.resetButton.addGestureRecognizer(resetTap)
    }
    
    @objc func convertButtonPressed(_ sender: UITapGestureRecognizer) {
        converter.getPairedConversionData()
    }
    
    @objc func resetButtonPressed(_ sender: UITapGestureRecognizer) {
        print("Pressed reset button")
    }
    
}

// MARK: - Layout

extension HomeViewController {
    
    private func configureLayout() {
        view.addSubview(converter.view)
        view.addSubview(converterToolbar)
        
        NSLayoutConstraint.activate([
            converter.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            converter.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            converter.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            converter.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            converterToolbar.topAnchor.constraint(equalTo: converter.view.bottomAnchor),
            converterToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            converterToolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            converterToolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
}
