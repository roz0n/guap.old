//
//  ConverterPanelButton.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

class ConverterPanelButton: UIButton {
    
    var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    convenience init() {
        self.init(label: nil)
    }
    
    init(label title: String?) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
