//
//  HeavyTextfield.swift
//  SAR
//
//  Created by Mohamed Shendy on 29/01/2023.
//  Copyright © 2023 Apple Company ~ iOS Team. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class HeavyTextfield: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateToNewFont()
        setLocaliz()
    }
    /**
     Setup font based on user device and base on Label attributes
     */
    func updateToNewFont() {
        self.font = FontManager.fontWithSize(size: self.font!.pointSize, style: HashTagFontStyle.heavy)
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
        return FontManager.fontWithSize(size: self.font().pointSize, style: HashTagFontStyle.heavy)
    }
    func setLocaliz() {
        self.placeholder = self.placeholder?.localiz()
        self.textColor = .black
        self.placeholderColor(color: Colors.textColor)
        if LanguageManager.shared.isRightToLeft
        {
            self.textAlignment   = .right
        }else
        {
            self.textAlignment   = .left
        }
    }
}
