//
//  TapableRocketCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 29/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

class TapableRocketCell: RocketCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.tapGestureRecognizer = UITapGestureRecognizer.init(target: self,
                                                                action: #selector(TapableRocketCell.handleTap(_:)))
        self.mainView.addGestureRecognizer(self.tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer!
    var isTapEnabled = true
    
    @objc
    fileprivate func handleTap(_ sender: UITapGestureRecognizer) {
        guard self.isTapEnabled else { return }
        self.mainView.smoothBounce(completionHandler: {
            self.notifyObserver(nextBlock: self.currentBlock?.child)
            self.isTapEnabled = false
        })
    }
    
}
