//
//  HashTagButton.swift
//  HashTag
//
//  Created by Mohamed Shendy on 29/01/2023.
//  Copyright © 2023 Apple Company ~ iOS Team. All rights reserved.
//

import UIKit

// MARK: - SARButton
@IBDesignable
class HashTagButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }


    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
    }
    // MARK: - Properties
    var titleFont: UIFont? = FontManager.fontWithSize(size: 18, style: .regular) {
        didSet {
            titleLabel?.font = titleFont
        }
    }

    // MARK: - Setup
    func setup() {
        layer.cornerRadius = 18
        clipsToBounds = true
        titleLabel?.font = titleFont
        setTitleColor(.white, for: .normal)
        setTitle(self.titleLabel?.text?.localiz(), for: .normal)
        self.backgroundColor = Colors.PrimaryColor
        tintColor = .white
    }

    // MARK: - InterfaceBuilder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}
