//
//  UIViewController+Ext.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/13/21.
//

import UIKit

extension UIViewController {
    
    func getRootViewController(of nestedViewController: UIViewController) -> UIViewController? {
        return nestedViewController.view.window?.rootViewController
    }
    
}
