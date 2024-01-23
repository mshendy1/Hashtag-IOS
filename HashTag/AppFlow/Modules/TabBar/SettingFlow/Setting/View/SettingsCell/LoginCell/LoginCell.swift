//
//  LoginCell.swift
//  HashTag
//
//  Created by Trend-HuB on 15/09/1444 AH.
//

import UIKit

class LoginCell: UITableViewCell {
    @IBOutlet weak var titleLbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension LoginCell:ReuseIdentifying{}
