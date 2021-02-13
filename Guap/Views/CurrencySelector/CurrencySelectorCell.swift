//
//  CurrencySelectorCell.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/12/21.
//

import UIKit

class CurrencySelectorCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CurrencySelectorCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
