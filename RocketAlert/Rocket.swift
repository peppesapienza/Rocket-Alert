//
//  Rocket.swift
//  Rocket
//
//  Created by Giuseppe Sapienza on 01/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

/// A powerful, light and userfriendly Alert View
public class Rocket: RocketControl {
    static var hasTabBar: Bool = false
    static var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    
    /**
    Initializes and returns a newly Rocket object with the specified author and block.
     
     - parameters:
        - author: the Author.
        - block: the first block showed by Rocket.
    */
    public required init(author: RocketAuthor, block: RocketBlock) {
        guard let vc = UIApplication.shared.topViewController() else {
            fatalError(RocketAlertError.cantFindRootViewController.localizedDescription)
        }
        
        Rocket.hasTabBar = vc.hasTabBarController
        self.topVC = vc
        self.block = block
        self.vc = RocketViewController.init(author: author)
        self.vc.rocket = self
        NotificationCenter.default.addObserver(self, selector: #selector(Rocket.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    public var closeButton: RocketCloseButton?
    
    fileprivate var topVC: UIViewController
    fileprivate let vc: RocketViewController!
    fileprivate let block: RocketBlock
    
    /// Show the Rocket Alert.
    public func show() {
        topVC.present(self.vc, animated: false, completion: {
            self.vc.show(block: self.block)
        })
    }
    
    /// Dismiss the Rocket Alert.
    public func dismiss() {
        vc.dismiss {}
    }
    
    @objc
    fileprivate func rotated() {
        if UIDevice.current.orientation.isLandscape {
            Rocket.isLandscape = true
        }
        
        if UIDevice.current.orientation.isPortrait {
            Rocket.isLandscape = false
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        //print("🔥 [Rocket] Deinit Rocket")
    }
    
}

public enum RocketAlertError: Error {
    case cantFindRootViewController
}

extension RocketAlertError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cantFindRootViewController: return "😵 [Rocket] I can't find the UIApplication.keyWindow.rootViewController"
        }
    }
}
