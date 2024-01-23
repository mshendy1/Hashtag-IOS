//
//  LogoutCell.swift
//  HashTag
//
//  Created by Trend-HuB on 15/09/1444 AH.
//

import UIKit

class LogoutCell: UITableViewCell {
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var logoutLbl:UILabel!
    @IBOutlet weak var btnLout:UIButton!
    @IBOutlet weak var img:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
extension LogoutCell:ReuseIdentifying{}
