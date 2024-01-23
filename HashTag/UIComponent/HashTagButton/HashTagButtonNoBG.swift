//
//  HashTagButtonNoBG.swift
//  SAR
//
//  Created by Mohamed Shendy on 29/01/2023.
//  Copyright © 2023 Apple Company ~ iOS Team. All rights reserved.
//

import UIKit

// MARK: - HashTagButton
@IBDesignable
class HashTagButtonNoBG: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }


    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
    }
    var titleFont: UIFont? = FontManager.fontWithSize(size: 16, style: .regular) {
        didSet {
            titleLabel?.font = titleFont
        }
    }

    // MARK: - Setup
    func setup() {
        titleLabel?.font = titleFont
        setTitle(self.titleLabel?.text?.localiz(), for: .normal)
    }

    // MARK: - InterfaceBuilder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}
