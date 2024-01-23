//
//  MediumLabel.swift
//  SAR
//
//  Created by Mohamed Shendy on 29/01/2023.
//  Copyright © 2023 Apple Company ~ iOS Team. All rights reserved.
//

import UIKit
class MediumLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateToNewFont()
        setLocaliz()
    }
    /**
     Setup font based on user device and base on Label attributes
     */
    func updateToNewFont() {
        self.font = FontManager.fontWithSize(size: self.font.pointSize, style: HashTagFontStyle.medium)
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
        return FontManager.fontWithSize(size: self.font().pointSize, style: HashTagFontStyle.medium)
    }
    func setLocaliz() {
        self.text = self.text?.localiz()
    }
}


