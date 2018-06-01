# RocketAlert

Would you like to improve your User Experiece's while asking user to do some action? 

Rockert Alert resolve the problem of be distracted by a boring AlertView with a user friendly boarding process similar to a Chat Bot. 

![alt text](https://media.giphy.com/media/5QLxkjz2nq5cHBENqr/giphy.gif)![alt text](https://media.giphy.com/media/9u15NC295RsZIKCDWj/giphy.gif)

With a modern style and a powerful personalization RocketAlert could help you to increase your conversion rate.

## Usage

**You can istantiate a `Rocket` by passing to his parameters a `RocketAuthor` and a `RocketBlock` object.** After that you can **present the `Rocket` by performing the method `show()`**:

```swift
import RocketAlert

let author = RocketAuthor.init(image: yourUIImage, style: RocketImageStyle.round)
let textBlock = TextRocketBlock.init(text: "This is your first Block")
let rocket = Rocket.init(author: author, block: textBlock)

rocket.show()
```

You can **destroy the alert by invoking the method `dismiss()`** on the same rocket object:

```swift
rocket.dismiss()
```

## The RocketBlock

 **`RocketBlock` is container of data and functionality** and under the hood `RocketBlock` is nothing else a simple `UITableViewCell`.

**Depends on block type a user can interact with a block by: *Tap*, *Control Events*** (for example button click) **and *Input Events*** (at the moment only text input). **After an event `Rocket` could show the next block** that has been attached to the interacted block.

**`RocketBlock` is a protocol that give to all blocks a `var id: String? {get set}` property** (created to be used in some advanced circumstances). There is also a `var cellIdentifier: String {get}` which is used internally to match the block with a reusable cell. 

```swift
public protocol RocketBlock {
    var id: String? { get set }
    var cellIdentifier: String { get }
}
```

**The `RocketBlock` protocol is never used as base protocol of the implemented class.** Instead you will use the inherited protocols that gives to the blocks some useful stuff. 


## TappableRocketBlock

The `TappableRocketBlock` is a inherited protocol from `RocketBlock`. The `TappableRocketBlock` protocol describe the block that could be tapped by the user. He gives to the implemented class two properties:

```swift
protocol TappableRocketBlock: RocketBlock {
    var next: RocketBlock? { get set }
    var showNextAfter: TimeInterval? { get set }
}
```

1. The `next` property represent the next `RocketBlock` that will be shown after the tap.  
2. The `showNextAfter` property allows the next block, if presented, to be shown automatically after an amount of time. If you provide a value the `TapGestureRecognizer` will be disabled.


### TextRocketBlock

**You can use `TextRocketBlock` object to show a line or multiline string.** The `TextRocketBlock` is an implemented class of the `TappableRocketBlock` protocol.

You can create a `TextRocketBlock` by using on of these init:

```swift
TextRocketBlock.init(text: String, next: RocketBlock, showNextAfter: TimeInterval? = nil)
TextRocketBlock.init(text: String, showNextAfter: TimeInterval)
TextRocketBlock.init(text: String, next: RocketBlock? = nil, showNextAfter: TimeInterval? = nil, id: String? = nil, font: RocketFont = .text)
```

#### Example 1.

```swift
let secondBlock = TextRocketBlock.init(text: "This is your second block")
let firstBlock = TextRocketBlock.init(text: "This is your first block", next: secondBlock)
        
let rocket = Rocket.init(author: author, block: firstBlock)
rocket.show()
```
The `secondBlock` will be presented after the tap on the `firstBlock`. Note that I passed the `firstBlock` to the `rocket`.

#### Example 2. ShowNextAfter

```swift
let thirdBlock = TextRocketBlock.init(text: "Third")
let secondBlock = TextRocketBlock.init(text: "Second", next: thirdBlock, showNextAfter: 2.0)
let firstBlock = TextRocketBlock.init(text: "First", next: secondBlock)
```

The `thirdBlock` will be shown automatically after 2.0 seconds and after the `secondBlock`.

#### Example 3. Flatten style

```swift
let firstBlock = TextRocketBlock.init(text: "First")
let secondBlock = TextRocketBlock.init(text: "Second")
let thirdBlock = TextRocketBlock.init(text: "Third")

firstBlock.next = second 
firstBlock.showNextAfter = 2.0

secondBlock.next = third
secondBlock.font = RocketFont.textBold
```

![Screenshot](https://image.ibb.co/nC4kLy/Schermata_2018_06_01_alle_17_23_18.png)

#### RocketFont

You can change the `UIFont` by providing a `RocketFont` object to the `font` property. 

```swift
let firstBlock = TextRocketBlock.init(text: "First", next: secondBlock)
firstBlock.font = RocketFont.init(font: UIFont, color: UIColor)
// or 
firstBlock.font = RocketFont.text // the default
```

The `RocketFont` provide some default styles:

```swift
public struct RocketFont {
    public static var text = RocketFont.init(font: UIFont.systemFont(ofSize: 18, weight: .regular), color: #colorLiteral(red: 0.1621472239, green: 0.2301641703, blue: 0.3008684814, alpha: 1))
    public static var textBold = RocketFont.init(font: UIFont.systemFont(ofSize: 18, weight: .bold), color: #colorLiteral(red: 0.1621472239, green: 0.2301641703, blue: 0.3008684814, alpha: 1))
    public static var button = RocketFont.init(font: UIFont.systemFont(ofSize: 20, weight: .black), color: #colorLiteral(red: 0.1902082911, green: 0.6098146351, blue: 0.968627451, alpha: 1))
    public static var lightButton = RocketFont.init(font: UIFont.systemFont(ofSize: 18, weight: .regular), color: #colorLiteral(red: 0.1902082911, green: 0.6098146351, blue: 0.968627451, alpha: 1))
    public static var cancel = RocketFont.init(font: UIFont.systemFont(ofSize: 20, weight: .semibold), color: #colorLiteral(red: 0.9267585874, green: 0.367726624, blue: 0.3804723024, alpha: 1))
    public static var emoji = RocketFont.init(font: UIFont.systemFont(ofSize: 25, weight: .black), color: #colorLiteral(red: 0.1621472239, green: 0.2301641703, blue: 0.3008684814, alpha: 1))
    
    public var color: UIColor
    public var font: UIFont
    
    public init() {
        self.color = UIColor.black
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    public init(font: UIFont, color: UIColor) {
        self.font = font
        self.color = color
    }
}

// USE:
block.font = RocketFont.text
block.font = RocketFont.emoji
block.font = RocketFont.textBold
```

## ControlRocketBlock

The `ControlRocketBlock` is a inherited protocol from `RocketBlock`. The `ControlRocketBlock` protocol describe the interactable blocks. 

### ButtonRocketBlock

**Use `ButtonRocketBlock` object to show a single button.** You can't define a `next`block directly. **Instead you need to provide a `TapRocketHandler` that let you to define a custom action and the next block** that will be fired after the `TouchUpInside` event.

You can create a `ButtonRocketBlock` using one of these init:

```swift
ButtonRocketBlock.init(title: String, tapHandler: TapRocketHandler) 
ButtonRocketBlock.init(title: String, tapHandler: TapRocketHandler, font: RocketFont)
ButtonRocketBlock.init(title: String, tapHandler: TapRocketHandler? = nil, font: RocketFont? = RocketFont.button, id: String? = nil)
```
The default `RocketFont` is `.button`. 

#### Example 4. 

```swift
let button = ButtonRocketBlock.init(title: "PRESS THERE")
let afterTheTapOnButton = TextRocketBlock.init(text: "You press the button!!")

button.tapHandler = TapRocketHandler.init(next: afterTheTapOnButton, action: {
    print("the user click the button")
    
    UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
        
    }
})

let rocket = Rocket.init(author: author, block: button)
rocket.show()
```
![alt text](https://media.giphy.com/media/wHf4k5qvG6bz8XvP7f/giphy.gif)

