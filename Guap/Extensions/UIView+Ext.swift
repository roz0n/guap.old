//
//  UIView+Ext.swift
//  Guap
//
//  Created by Arnaldo Rozon on 1/31/21.
//

import UIKit

enum UIViewBorders: String {
    case Left = "left"
    case Right = "right"
    case Top = "top"
    case Bottom = "bottom"
}

extension UIView {
    
    func fillOther(view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addBorder(borders: [UIViewBorders], color: UIColor, width: CGFloat) {
        borders.forEach { (border) in
            let borderView = CALayer()
            
            borderView.backgroundColor = color.cgColor
            borderView.name = border.rawValue
            
            switch border {
                case .Left:
                    borderView.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
                case .Right:
                    borderView.frame = CGRect(x:self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
                case .Top:
                    borderView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
                case .Bottom:
                    borderView.frame = CGRect(x: 0, y: self.frame.size.height - width , width: self.frame.size.width, height: width)
            }
            
            self.layer.addSublayer(borderView)
        }
    }
    
}
