//
//  SearchCell.swift
//  HashTag
//
//  Created by Eman Gaber on 26/02/2023.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var lbltitle:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SearchCell:ReuseIdentifying{}
