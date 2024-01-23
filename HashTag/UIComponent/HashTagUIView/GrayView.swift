//
//  GrayView.swift
//  HashTag
//
//  Created by Mohamed Shedy on 05/02/2023.
//

import Foundation
import UIKit

// MARK: - SARButton
@IBDesignable
class GrayView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Setup
    func setup() {
        layer.cornerRadius = 14
        clipsToBounds = true
        self.backgroundColor = Colors.grayColor
    }

    // MARK: - InterfaceBuilder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}
