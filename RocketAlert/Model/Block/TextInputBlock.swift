//
//  TextInputBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 06/05/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class TextInputRocketBlock: InputRocketBlock {
    
    public init(
        text: String,
        buttonTitle: String,
        inputHandler: InputRocketHandler<String>,
        id: String? = nil,
        style: RocketElementStyle? = RocketElementStyle.text,
        buttonStyle: RocketElementStyle? = RocketElementStyle.lightButton)
    {
        self.text = text
        self.buttonTitle = buttonTitle
        self.handler = inputHandler
        self.style = style
        self.buttonStyle = buttonStyle
    }
    
    public var id: String?
    
    internal let text: String
    internal let buttonTitle: String
    internal let handler: InputRocketHandler<String>
    internal let style: RocketElementStyle?
    internal let buttonStyle: RocketElementStyle?
}
