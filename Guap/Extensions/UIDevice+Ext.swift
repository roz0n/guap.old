//
//  UIDevice+Ext.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/8/21.
//

import UIKit
import AVFoundation

extension UIDevice {
    
    // TODO: This is a long kind of vibration, can we find others that are more subtle?
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
}
