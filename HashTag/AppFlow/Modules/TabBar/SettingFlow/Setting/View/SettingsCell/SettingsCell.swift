//
//  SettingsCell.swift
//  HashTag
//
//  Created by Trend-HuB on 29/07/1444 AH.
//

import UIKit

class SettingsCell: UITableViewCell {
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var titleLbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SettingsCell:ReuseIdentifying{}
