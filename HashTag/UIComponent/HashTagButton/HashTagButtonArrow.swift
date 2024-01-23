//
//  HashTagButtonArrow.swift
//  SAR
//
//  Created by Mohamed Shendy on 29/01/2023.
//  Copyright © 2023 Apple Company ~ iOS Team. All rights reserved.
//

import UIKit
import LanguageManager_iOS

// MARK: - HashTagButtonArrow
@IBDesignable
class HashTagButtonArrow: HashTagButtonNoBG {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Setup
    override func setup() {
        super.setup()
        let isEn = LanguageManager.shared.currentLanguage == .en
        semanticContentAttribute = (isEn ? .forceRightToLeft : .forceLeftToRight)
        
        let image = UIImage(named: "down")
        let imageToUse  = (isEn ? image : UIImage(cgImage: image!.cgImage!, scale: image!.scale, orientation: .upMirrored))
        image?.withTintColor(.white)
        setImage(imageToUse, for: .normal)
        self.tintColor = .gray
        centerTextAndImage(spacing: 12)
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let isRTL = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
        if isRTL {// can remove 70
           imageEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount + 70, bottom: 0, right: -insetAmount)
           titleEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
           contentEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: -insetAmount)
        } else {
           imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
           titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
           contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }

    // MARK: - InterfaceBuilder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

class HashTagButtonSideArrow: HashTagButtonNoBG {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Setup
    override func setup() {
        super.setup()
        let isEn = LanguageManager.shared.currentLanguage == .en
        semanticContentAttribute = (isEn ? .forceRightToLeft : .forceLeftToRight)
        
        let image =  UIImage(systemName: "chevron.right")
        let imageToUse  = (isEn ? image : UIImage(cgImage: image!.cgImage!, scale: image!.scale, orientation: .upMirrored))
        image?.withTintColor(.white)
        setImage(imageToUse, for: .normal)
        self.tintColor = Colors.textColor
        centerTextAndImage(spacing: 10)
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let isRTL = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
        if isRTL {// can remove 70
           imageEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount + 70, bottom: 0, right: -insetAmount)
           titleEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
           contentEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: -insetAmount)
        } else {
           imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
           titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
           contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }

    // MARK: - InterfaceBuilder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

extension UIButton {
   func selectedButton(title:String, iconName: String, widthConstraints: NSLayoutConstraint){
       self.backgroundColor = Colors.PrimaryColor
   self.setTitle(title, for: .normal)
   self.setTitle(title, for: .highlighted)
   self.setTitleColor(UIColor.white, for: .normal)
   self.setTitleColor(UIColor.white, for: .highlighted)
   self.setImage(UIImage(named: iconName), for: .normal)
   self.setImage(UIImage(named: iconName), for: .highlighted)
   let imageWidth = self.imageView!.frame.width
       let textWidth = (title as NSString).size(withAttributes:[NSAttributedString.Key.font:self.titleLabel!.font!]).width
   let width = textWidth + imageWidth + 24
   //24 - the sum of your insets from left and right
   widthConstraints.constant = width
   self.layoutIfNeeded()
   }
}
