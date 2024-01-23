//
//  FAQCell.swift
//  SHAHM
//
//  Created by Eman Gaber on 23/01/2023.
//

import UIKit

class FAQCell: UITableViewCell {
    @IBOutlet weak var lblQues:UILabel!
    @IBOutlet weak var lblAnswer:UILabel!
    @IBOutlet weak var stackDetails:UIStackView!
    @IBOutlet weak var img:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configur(model:QuesModel?){
        lblQues.text = (model?.question ?? "").htmlToString
        lblAnswer.text = (model?.answer ?? "").htmlToString
    }
    
}
extension FAQCell:ReuseIdentifying{}
