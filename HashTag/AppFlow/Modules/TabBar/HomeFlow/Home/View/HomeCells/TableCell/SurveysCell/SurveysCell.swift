//
//  SurveysCell.swift
//  HashTag
//
//  Created by Trend-HuB on 21/07/1444 AH.
//

import UIKit

class SurveysCell: UITableViewCell {
    @IBOutlet weak var imgBlure: UIImageView!
    @IBOutlet weak var btnImgBlure: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnFav:UIButton!
    @IBOutlet weak var viewFav:UIView!
    @IBOutlet weak var btnViewSurvey:UIButton!
    @IBOutlet weak var imgFav:UIImageView!
    @IBOutlet weak var btnShare:UIButton!
    @IBOutlet weak var btnShowDetails:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        btnViewSurvey.setTitle(Constants.buttons.btnViewServey, for: .normal)
    }
    
   
    func configPollCell(model:PollModel?){
        if model?.type == "four_image"{
            img.loadImage(path: model?.images?.first ?? "")
        }else if model?.type == "video"{
            // video
            let videoUrl = URL(string: model?.video ?? "")!
        if let thumbnailImage = General.getThumbnailImage(forUrl:videoUrl as URL ) {
                img.image = thumbnailImage
            }
        }else{
            img.loadImage(path: model?.image ?? "")
        }
        let day:String = model?.createdAtDayNumber ?? ""
        let month:String = model?.createdAtMonth ?? ""
        let dayName:String = model?.createdAtDay ?? ""
        let dateTxt = "\(day) \(month) . \(dayName)"
      
        lblDate.text = dateTxt
        lblDesc.text = model?.title ?? ""
        lblCategory.text = model?.category?.first?.name
        img.contentMode = .scaleAspectFill
        icon.loadImage(path: model?.category?.first?.icon ?? "")

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
    }
    
    
     func configSearchPoll(model:SearchPollsModel?){
//         let day:String = model?.createdAtDayNumber ?? ""
//         let month:String = model?.createdAtMonth ?? ""
//         let dayName:String = model?.createdAtDay ?? ""
//         let dateTxt = "\(day) \(month) . \(dayName)"
       
         lblDate.text = model?.allDate ?? ""
         lblDesc.text = model?.title ?? ""
         lblCategory.text = model?.category?.first?.name
         img.loadImage(path: model?.media ?? "")
         img.contentMode = .scaleAspectFill
         icon.loadImage(path: model?.category?.first?.icon ?? "")

         let bgColorView = UIView()
         bgColorView.backgroundColor = UIColor.clear
         self.selectedBackgroundView = bgColorView
     }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension SurveysCell:ReuseIdentifying{}
