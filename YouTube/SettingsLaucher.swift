//
//  settingsLaucher.swift
//  YouTube
//
//  Created by Tran's Macpro on 3/19/17.
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

class SettingsLaucher: NSObject {
    
    
    
    let blackView = UIView()
    func showSetting() {
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SettingsLaucher.handleDismiss)))
            blackView.frame = window.frame
            window.addSubview(blackView)
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
            })
            
        }
        
    }
    //handleDissmiss more Button
    func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }
    override init() {
        super.init()
        
     
    }
}
