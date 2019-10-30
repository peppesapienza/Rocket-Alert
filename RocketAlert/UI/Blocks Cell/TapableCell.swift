//
//  TapableRocketCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 29/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

class TapableRocketCell: RocketCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.tapGestureRecognizer = UITapGestureRecognizer.init(target: self,
                                                                action: #selector(TapableRocketCell.handleTap(_:)))
        self.mainView.addGestureRecognizer(self.tapGestureRecognizer)
    }
    
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer!
    var isTapEnabled = true
    
    @objc
    fileprivate func handleTap(_ sender: UITapGestureRecognizer) {
        guard isTapEnabled else { return }
        tapAction()
    }
    
    func tapAction() {
        self.mainView.smoothBounce(completionHandler: {
            self.show(next: (self.currentBlock as? TappableRocketBlock)?.next)
            self.isTapEnabled = false
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
