//
//  CheckBoxButton.swift
//  HashTag
//
//  Created by Mohamed Shendy on 06/02/2023.
//

import Foundation
import UIKit
class CheckboxButton: UIButton {
    // Variables for checked/unchecked state
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                self.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                self.tintColor = Colors.PrimaryColor
                
            } else {
                self.setImage(UIImage(systemName: "square"), for: .normal)
                self.tintColor = .lightGray

            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
