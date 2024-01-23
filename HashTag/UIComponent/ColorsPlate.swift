//
//  ColorsPlate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 05/02/2023.
//

import Foundation
import UIKit

struct Colors {
    
    
    static let PrimaryColor = UIColor(hex: "#059E4B")
    static let bgColor = UIColor(hex: "#F4F7F9")
    static let grayColor = UIColor(hex: "#F1F4F7")
    static let lightGray = UIColor(hex: "#EBF1F4")
    static let textColor = UIColor(hex: "#777E90")
    static let wh = UIColor(hex: "#FFFFFF")
    static let Black = UIColor(hex: "#202124")
    static let borderColor = UIColor(hex: "#F1F4F7")
    static let selectedBtnColor = UIColor(hex: "#EBF1F4")
    static let unSelectGray = UIColor(hex: "#737988")
    static let btnBookMark = UIColor(hex: "3C3C43")
}

extension UIColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hexString).scanHexInt32(&int)
        let a, r, g, b: UInt32

        switch hexString.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }


}
