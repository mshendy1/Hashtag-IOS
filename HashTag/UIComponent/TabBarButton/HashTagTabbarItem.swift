//
//  HashTagTabbarItem.swift
//  SAR
//
//  Created by Mohamed Shendy on 29/01/2023.
//  Copyright © 2023 Apple Company ~ iOS Team. All rights reserved.
//

import UIKit

class HashTagTabbarItem: UITabBarItem {

    override func awakeFromNib() {
        super.awakeFromNib()
        setLocaliz()
    }

    func setLocaliz() {
        self.title = self.title?.localiz()
        
    }
}
