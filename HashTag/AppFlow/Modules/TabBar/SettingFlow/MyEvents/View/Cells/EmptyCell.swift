//
//  EmptyCell.swift
//  HashTag
//
//  Created by Trend-HuB on 18/02/1445 AH.
//

import UIKit

class EmptyCell: UITableViewCell {
    
    @IBOutlet weak var lblEmptyMsg:UILabel!{
        didSet{
            lblEmptyMsg.text = Constants.messages.emptyEvents
        }
    }
    @IBOutlet weak var btnAddEvent:UIButton!{
        didSet{
            btnAddEvent.setTitle(Constants.titles.addNewEvent, for: .normal)
            let icon = UIImage(named:"addEvent")!
            btnAddEvent.setImage(icon, for: .normal)
            btnAddEvent.imageView?.contentMode = .scaleAspectFit
            btnAddEvent.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
            btnAddEvent.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension EmptyCell:ReuseIdentifying{}
