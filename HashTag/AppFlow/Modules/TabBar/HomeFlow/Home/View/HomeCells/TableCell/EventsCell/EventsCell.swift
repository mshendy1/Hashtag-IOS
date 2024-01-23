//
//  NewsCellsTableViewCell.swift
//  HashTag
//
//  Created by Trend-HuB on 21/07/1444 AH.
//

import UIKit

class EventsCell: UITableViewCell {
    
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var timeLbl:UILabel!
    @IBOutlet weak var addressLbl:UILabel!
    @IBOutlet weak var monthLbl:UILabel!
    @IBOutlet weak var dayLbl:UILabel!
    @IBOutlet weak var btnFav:UIButton!
    @IBOutlet weak var imgFav:UIImageView!
    @IBOutlet weak var viewFav:UIView!
    @IBOutlet weak var btnPlay:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    func configCell(event:EventModel?){
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
        titleLbl.text = event?.title
        timeLbl.text = "\(event?.createdTime ?? "") \(event?.timeAmOrPm ?? "")"
        dayLbl.text = event?.createAtDayNumber
        monthLbl.text = event?.createdAtMonth
        addressLbl.text = event?.location
        if event?.video == "" {
            btnPlay.isHidden = true
        }else{
            btnPlay.isHidden = false
        }
        img.loadImage(path: event?.mainPhoto ?? "")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        if event?.bookmark == true{
        imgFav.image = UIImage.init(named: "FAV")
        viewFav.backgroundColor = Colors.PrimaryColor
        }else{
        imgFav.image = UIImage.init(named: "FAV")
        }
    }
    
    
    func configSearchCell(event:SearchEventsModel?){
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
        titleLbl.text = event?.title
        if event?.video == "" {
            btnPlay.isHidden = true
        }else{
            btnPlay.isHidden = false
        }
//        timeLbl.text = "\(event?.createdTime ?? "") \(event?.timeAmOrPm ?? "")"
//        dayLbl.text = event?.createAtDayNumber
//        monthLbl.text = event?.createdAtMonth
        addressLbl.text = event?.location
        img.loadImage(path: event?.mainPhoto ?? "")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}


extension EventsCell:ReuseIdentifying{}
 
