//
//  MyEventsCell.swift
//  HashTag
//
//  Created by Eman Gaber on 26/02/2023.
//

import UIKit

class MyEventsCell: UITableViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var imgState:UIImageView!
    @IBOutlet weak var lblStates:UILabel!
    @IBOutlet weak var lblLocation:UILabel!
    @IBOutlet weak var lblTime:UILabel!
    @IBOutlet weak var lblDay:UILabel!
    @IBOutlet weak var lblMonth:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configer(model:Events?){
        lblTitle.text = model?.title
        lblStates.text = model?.status
        lblLocation.text = model?.location
        let timeMode = model?.timeAmOrPm ?? ""
        let time = model?.createdTime ?? ""
        lblTime.text = "\(time)-\(timeMode)"
        lblDay.text = model?.createAtDayNumber
        lblMonth.text = model?.createdAtMonth
    }
    
}

extension MyEventsCell:ReuseIdentifying{}

