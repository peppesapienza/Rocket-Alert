//
//  MainViewFinder.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 02/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

extension UIApplication {

    func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
    
}

extension UIDevice {
    var isPad: Bool {
        return self.userInterfaceIdiom == .pad
    }
    
    var isPhone: Bool {
        return self.userInterfaceIdiom == .phone
    }
}

extension UIViewController {
    
    var hasTabBarController: Bool {
        return self.tabBarController != nil ? true : false
    }
    
    var hasNavigationController: Bool {
        return self.navigationController != nil ? true : false
    }
    
}
