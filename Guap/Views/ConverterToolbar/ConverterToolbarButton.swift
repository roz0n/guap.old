//
//  ConverterToolbarButton.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/7/21.
//

import UIKit

class ConverterToolbarButton: UIButton {
    
    var icon: UIImage?
    var iconColor: UIColor
    var bgColor: UIColor
    
    init(icon: UIImage?, iconColor: UIColor, bgColor: UIColor) {
        self.icon = icon ?? nil
        self.iconColor = iconColor
        self.bgColor = bgColor
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bgColor
        
        configureIcons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureIcons() {
        let formattedIcon = self.icon?.withTintColor(K.colors.white)
        setImage(formattedIcon, for: .normal)
        tintColor = K.colors.black
    }
    
}
