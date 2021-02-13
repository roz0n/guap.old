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
        navigationItem.title = "Select \(type.rawValue.capitalized) Currency"
        
        configureLayout()
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
