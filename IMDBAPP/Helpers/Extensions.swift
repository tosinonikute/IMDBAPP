//
//  Extensions.swift
//  IMDBAPP
//
//  Created by MACBOOK PRO on 21/03/2019.
//  Copyright © 2019 MACBOOK PRO. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showHUD(progressLabel:String){
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = progressLabel
    }
    
    func dismissHUD(isAnimated:Bool) {
        MBProgressHUD.hide(for: self.view, animated: isAnimated)
    }
    
    func showHUD(){
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.backgroundColor = UIColor.clear
    }
}
