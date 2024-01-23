//
//  ExpandableView.swift
//  HashTag
//
//  Created by Trend-HuB on 28/12/1444 AH.
//

import Foundation
import UIKit

class ExpandableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        translatesAutoresizingMaskIntoConstraints = false

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}
