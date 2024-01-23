//
//  TrendNewsCell.swift
//  HashTag
//
//  Created by Trend-HuB on 22/07/1444 AH.
//

import UIKit

class TrendGoogleNewsCell: UITableViewCell {

    @IBOutlet weak var dateLbl: MediumLabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet var tittleLbl: MediumLabel!
    @IBOutlet var desLbl: RegularLabel!
    @IBOutlet var sourceLbl: RegularLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(model:TrendGoogleNewsModel?){
        dateLbl.text = "\(model?.createAtDayNumber ?? "") \(model?.createdDateMonth ?? "") . \(model?.createdDateDay ?? "")"
        
        sourceLbl.text = "#\(model?.source ?? "")"
        tittleLbl.text = model?.title ?? ""
        desLbl.text = model?.description ?? ""
        img.loadImage(path: model?.image ?? "")
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TrendGoogleNewsCell:ReuseIdentifying{}
