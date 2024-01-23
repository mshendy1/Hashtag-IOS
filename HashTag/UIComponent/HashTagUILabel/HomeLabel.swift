//
//  HomeLabel.swift
//  SAR
//
//  Created by Mohamed Shendy on 29/01/2023.
//  Copyright © 2023 Apple Company ~ iOS Team. All rights reserved.
//

import UIKit
class HomeLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateToNewFont()
        setLocaliz()
    }
    override var text: String? {
        willSet {
            if newValue == "Select Arrival Station".localiz()  || newValue == "Select Departure Station".localiz() {
                self.font = FontManager.fontWithSize(size: 16, style: HashTagFontStyle.regular)
            } else {
                self.font = FontManager.fontWithSize(size: 21, style: HashTagFontStyle.bold)
            }
        }
    }
    /**
     Setup font based on user device and base on Label attributes
     */
    func updateToNewFont() {
        self.font = FontManager.fontWithSize(size: 16, style: HashTagFontStyle.regular)
    }
    /**
     Update font based parameters
     - parameter size: The new font size
     - parameter style: enum LUNAFontStyle to change font based on it
     */
    func updateFont(size: CGFloat, style: HashTagFontStyle) {
        self.font = FontManager.fontWithSize(size: size, style: style)
    }
    
    class func font() -> UIFont {
        return FontManager.fontWithSize(size: self.font().pointSize, style: HashTagFontStyle.bold)
    }
    func setLocaliz() {
        self.text = self.text?.localiz()
    }
}

