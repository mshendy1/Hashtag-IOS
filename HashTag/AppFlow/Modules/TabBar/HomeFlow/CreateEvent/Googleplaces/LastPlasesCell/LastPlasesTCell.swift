//
//  LastPlasesTCell.swift
//  Drovox Passenger
//
//  Created by Apple on 30/09/2021.
//

import UIKit

class LastPlasesTCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension LastPlasesTCell: ReuseIdentifying {}
