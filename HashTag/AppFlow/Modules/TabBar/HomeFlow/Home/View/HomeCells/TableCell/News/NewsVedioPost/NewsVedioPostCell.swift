//
//  NewsVedioPostCell.swift
//  HashTag
//
//  Created by Trend-HuB on 21/07/1444 AH.
//

import UIKit

class NewsVedioPostCell: UITableViewCell {
    @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblDisc:UILabel!
    @IBOutlet weak var lbldate:UILabel!
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var btnFav:UIButton!
    @IBOutlet weak var btnShare:UIButton!
    @IBOutlet weak var imgFav:UIImageView!
    @IBOutlet weak var lbllikesCount:UILabel!
    @IBOutlet weak var imgLike:UIImageView!
    @IBOutlet weak var lblCommentsCount:UILabel!
    @IBOutlet weak var lblViewsCount:UILabel!
    @IBOutlet weak var btnLike:UIButton!
    @IBOutlet weak var viewFav:UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configVideoCell(posts:NewsPostsModel?){
        lblCategory.text = posts?.category?.name
        lblDisc.text = posts?.title
        lbldate.text = "\(posts?.createAtDayNumber ?? "") \(posts?.createdDateMonth ?? "") . \(posts?.createdDateDay ?? "")"
        lbllikesCount.text = "\(posts?.likeCount ?? 0)"
        if posts?.like == true{
            lbllikesCount.textColor = Colors.PrimaryColor
            imgLike.tintColor = Colors.PrimaryColor
        }else{
            lbllikesCount.textColor = Colors.unSelectGray
            imgLike.tintColor = Colors.unSelectGray
        }
        lblCommentsCount.text = "\(posts?.commentsCount ?? 0)"
        lblViewsCount.text = "\(posts?.viewCount ?? 0)"
        img.loadImage(path: posts?.photo  ?? "")
        icon.loadImage(path:posts?.category?.icon ?? "")
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
    }
    
    func configFavVideoCell(favPosts:FavPostsModel?){
        lblCategory.text = favPosts?.category?.name
        lblDisc.text = favPosts?.title
        lbldate.text = favPosts?.createdDate
        img.loadImage(path: favPosts?.photo  ?? "")
        icon.loadImage(path:favPosts?.category?.icon ?? "")
        if favPosts?.bookmark == true{
        imgFav.image = UIImage.init(named: "FAV")
        viewFav.backgroundColor = Colors.PrimaryColor
        }else{
        imgFav.image = UIImage.init(named: "FAV")
        }
        lbllikesCount.text = "\(favPosts?.likeCount ?? 0)"
        if favPosts?.like == true{
            lbllikesCount.textColor = Colors.PrimaryColor
            imgLike.tintColor = Colors.PrimaryColor
        }else{
            lbllikesCount.textColor = Colors.unSelectGray
            imgLike.tintColor = Colors.unSelectGray
        }

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
    }
    
    func configSearchVideoCell(posts:SearchPostModel?){
        lblCategory.text = posts?.category?.name
        lblDisc.text = posts?.title
        lbldate.text = posts?.createdDate
//        img.loadImage(path: posts?.photo  ?? "")
        icon.loadImage(path:posts?.category?.icon ?? "")
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
    }
    
}
extension NewsVedioPostCell:ReuseIdentifying{}
