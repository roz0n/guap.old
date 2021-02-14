//
//  CurrencySelectorViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/6/21.
//

import UIKit

class CurrencySelectorViewController: UIViewController {
    
    var type: CurrencyType
    let currencySelector = CurrencySelectorCollectionView()
    
    init(type: CurrencyType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationButtons()
        configureLayout()
    }
    
    private func configureNavigationButtons() {
        let closeButtonIcon = UIImage(systemName: "xmark")
        let doneButtonIcon = UIImage(systemName: "checkmark")
        
        navigationItem.title = "Select \(type.rawValue.capitalized) Currency"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeButtonIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: doneButtonIcon, style: .plain, target: self, action: #selector(doneButtonTapped))
    }
    
}

// MARK: - Gestures

private extension CurrencySelectorViewController {
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - Layout

private extension CurrencySelectorViewController {
    
    func configureLayout() {
        view.addSubview(currencySelector.view)
        NSLayoutConstraint.activate([
            currencySelector.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currencySelector.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currencySelector.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            currencySelector.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}
