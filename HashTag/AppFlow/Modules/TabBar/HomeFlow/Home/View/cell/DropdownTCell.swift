//
//  DropdownTCell.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.
//

import UIKit

class DropdownTCell: UITableViewCell {
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var bgView: UIView!

    var selectedBackgroundColor: UIColor?
    var highlightTextColor: UIColor?
    var normalTextColor: UIColor?
    
}


extension DropdownTCell:ReuseIdentifying{}
 
