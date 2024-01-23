//
//  TwitterCell.swift
//  HashTag
//
//  Created by Trend-HuB on 22/07/1444 AH.
//

import UIKit
import LanguageManager_iOS

class TwitterCell: UITableViewCell {

    @IBOutlet weak var lblNum:UILabel!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblVolum:UILabel!
    @IBOutlet weak var lblTExtVolum:UILabel!
    @IBOutlet weak var lineLbl:UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configTwitterCell(model:TrendTwitterModel?)  {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
        self.lblTitle.text = "# \(model?.name ?? "")"
        let volum = model?.tweetVolume ?? ""
        lblTExtVolum.text = "tweets".localiz()
        //let tweet = "tweets".localiz()
        self.lblVolum.text = "\(volum)"
        if model?.tweetVolume == "null"{
            lblTExtVolum.text = ""
        }
        
    }
    
        func configeNewsCell(model:TrendGoogleModel?){
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
        self.lblVolum.text = "\(model?.traffic ?? "") "
        lblTExtVolum.text = "Searches".localiz()
        if model?.traffic == "null"{
            lblTExtVolum.text = ""
        }

        


        self.lblTitle.text = "# \(model?.title ?? "")"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TwitterCell:ReuseIdentifying{}
