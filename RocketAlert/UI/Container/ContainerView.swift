//
//  RocketBackgroundView.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 02/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class RocketContainerView: UIView {
    
    init(superView: UIView) {
        self.container = superView
        super.init(frame: .zero)
        self.backgroundColor = .clear
        superView.addSubview(self)
        self.setAutoresizingMask()
        self.setConstraints()
    }

    weak var container: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // deinit { print("🔥 [Rocket] Deinit RocketContainerView") }
    
}

extension RocketContainerView: RocketViewLayout {
    func setAutoresizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        self.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: self.container.centerYAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            self.heightAnchor.constraint(equalTo: self.container.safeAreaLayoutGuide.heightAnchor).isActive = true
            self.widthAnchor.constraint(equalTo: self.container.safeAreaLayoutGuide.widthAnchor).isActive = true
        } else {
            self.heightAnchor.constraint(equalTo: self.container.heightAnchor).isActive = true
            self.widthAnchor.constraint(equalTo: self.container.widthAnchor).isActive = true
        }
    }
    
}
