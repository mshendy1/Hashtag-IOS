//
//  AddPollsCell.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import UIKit

class AddPollsCell: UITableViewCell {
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblCount:UILabel!
    @IBOutlet weak var lblPercentage:UILabel!
    @IBOutlet weak var bigViewSlider:UIView!
    @IBOutlet weak var votesProgress:LinearProgressBar!
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var btnAddPoll:UIButton!
    @IBOutlet weak var votesStack:UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func calculateWidth(items: [Item],index:Int,tabel:UITableView){
        var totalCount = 0
        for model in items {
            totalCount += model.count ?? 0
        }
        let model = items[index]
        votesProgress.capType = Int32(0)
        if totalCount > 0 {
            let count = model.count ?? 0
            let persentag :Float = Float(count)/Float(totalCount) * 100.0
            print(persentag)
            votesProgress.progressValue = CGFloat(persentag )
            lblPercentage.text = String(format: "%.2f", persentag).appending(" %")
        }
        else {
            lblPercentage.text = "0 %"
            votesProgress.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AddPollsCell:ReuseIdentifying{}
