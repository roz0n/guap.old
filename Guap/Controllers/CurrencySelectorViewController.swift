//
//  CurrencySelectorViewController.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/6/21.
//

import UIKit

class CurrencySelectorViewController: UIViewController {
    
    var type: CurrencyType
    
    init(type: CurrencyType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        navigationItem.title = "Select \(type.rawValue.capitalized) Currency"
    }

}
