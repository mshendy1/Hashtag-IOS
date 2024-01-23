//
//  NotificatiosCell.swift
//  HashTag
//
//  Created by Eman Gaber on 26/02/2023.
//

import UIKit

class NotificatiosCell: UITableViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var lblBody:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configer(model:Notifications?){
        lblTitle.text = model?.title
        lblBody.text = model?.des
        lblDate.text = model?.date
        DispatchQueue.main.async{
        self.img.loadImage(path: model?.image ?? "")
        }
        
    }
    
}

extension NotificatiosCell:ReuseIdentifying{}

