//
//  ReplayCell.swift
//  HashTag
//
//  Created by Trend-HuB on 24/07/1444 AH.
//

import UIKit

class ReplayCell: UITableViewCell {
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var imgUser:UIImageView!
    @IBOutlet weak var lblCommentText:UILabel!
    @IBOutlet weak var lblDate:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configerCell(model:ReplayModel?){
        lblName.text = model?.user?.name ?? ""
        //imgUser.contentMode = .scaleAspectFit
        imgUser.clipsToBounds = true
        lblCommentText.text = model?.comment ?? ""
        let date = model?.createAtDate
        lblDate.text = "\(date ?? "")"
        
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        if let date = inputFormatter.date(from: dateString) {
          let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format
            print(outputFormatter)
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
}
extension ReplayCell:ReuseIdentifying{}
