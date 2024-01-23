//
//  NewsVegaCells.swift
//  HashTag
//
//  Created by Trend-HuB on 30/11/1444 AH.
//

import UIKit
import VerticalCardSwiper

class NewsCardsCell: CardCell {
    @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblDisc:UILabel!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lbldate:UILabel!
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var btnFav:UIButton!
    @IBOutlet weak var imgFav:UIImageView!
    @IBOutlet weak var viewFav:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configPostCardsCell(posts:NewsPostsModel?){
        lblCategory.text = posts?.category?.name
        lblDisc.text = posts?.title
        lblTitle.text = posts?.desc
//        lbllikesCount.text = "\(posts?.likeCount ?? 0)"
//        if posts?.like == true{
//            lbllikesCount.textColor = Colors.PrimaryColor
//            imgLike.tintColor = Colors.PrimaryColor
//        }else{
//            lbllikesCount.textColor = Colors.unSelectGray
//            imgLike.tintColor = Colors.unSelectGray
//        }
//        lblCommentsCount.text = "\(posts?.commentsCount ?? 0)"
//        lblViewsCount.text = "\(posts?.viewCount ?? 0)"
        lbldate.text = "\(posts?.createAtDayNumber ?? "") \(posts?.createdDateMonth ?? "") . \(posts?.createdDateDay ?? "")"
        img.loadImage(path: posts?.photo  ?? "")
        icon.loadImage(path:posts?.category?.icon ?? "")
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
    }

}
