//
//  FontManager.swift
//  SAR
//
//  Created by Mohamed Shendy on 29/01/2023.
//  Copyright © 2023 Apple Company ~ iOS Team. All rights reserved.
//

import UIKit
import LanguageManager_iOS

enum HashTagFontStyle: String {

    case light = "DINNextLTW23-Light"
    case regular = "DIN Next LT W23 Regular"
    case medium = "DIN Next LT W23 Medium"
    case heavy = "DIN Next LT W23 Heavy"
   case bold = "DINNextLTW23-Bold2"
    
 
    func light(isEn: Bool) -> String {
        return  (isEn ? "DINNextLTW23-Light" : "DINNextLTW23-Light")
    }
    func regular(isEn: Bool) -> String {
        return  (isEn ? "DIN Next LT W23 Regular" : "DIN Next LT W23 Regular")
    }
    func medium(isEn: Bool) -> String {
        return  (isEn ? "DIN Next LT W23 Medium" : "DIN Next LT W23 Medium")
    }
    func heavy(isEn: Bool) -> String {
        return  (isEn ? "DIN Next LT W23 Heavy" : "DIN Next LT W23 Heavy")
    }
    
    func bold(isEn: Bool) -> String {
        return  (isEn ? "DINNextLTW23-Bold2" : "DINNextLTW23-Bold2")
    }
}

struct FontManager {
    static func fontWithSize( size: CGFloat, style: HashTagFontStyle = HashTagFontStyle.regular ) -> UIFont {
        return font(withSize: size, style: style)
    }

    static func font(withSize size: CGFloat, style: HashTagFontStyle = HashTagFontStyle.regular ) -> UIFont {
        let isEn = LanguageManager.shared.currentLanguage == .en
        switch style {
        case .light:
            if let font = UIFont(name: style.light(isEn: isEn), size: size) {
                return font
            }
        case .regular:
            if let font = UIFont(name: style.regular(isEn: isEn), size: size) {
                return font
            }
        case .bold:
            if let font = UIFont(name: style.bold(isEn: isEn), size: size) {
                return font
            }
        case .medium:
            if let font = UIFont(name: style.medium(isEn: isEn), size: size) {
                return font
            }
        case .heavy:
            if let font = UIFont(name: style.heavy(isEn: isEn), size: size) {
                return font
            }
        }
        if style == .bold || style == .light {
            return UIFont.boldSystemFont(ofSize: size)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    static func preferredFontSize() -> Int {
        return 30
    }
}
