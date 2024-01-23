//
//  NewsCell.swift
//  HashTag
//
//  Created by Trend-HuB on 21/07/1444 AH.
//

import UIKit

class NewsPostCell: UITableViewCell {
    @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblDisc:UILabel!
    @IBOutlet weak var lbllikesCount:UILabel!
    @IBOutlet weak var imgLike:UIImageView!
    @IBOutlet weak var lblCommentsCount:UILabel!
    @IBOutlet weak var lblViewsCount:UILabel!
    @IBOutlet weak var lbldate:UILabel!
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var btnLike:UIButton!
    @IBOutlet weak var btnFav:UIButton!
    @IBOutlet weak var btnShare:UIButton!
    @IBOutlet weak var imgFav:UIImageView!
    @IBOutlet weak var viewFav:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    func configPostsCell(posts:NewsPostsModel?){
            lblCategory.text = posts?.category?.name
            lblDisc.text = posts?.title
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
            lbldate.text = "\(posts?.createAtDayNumber ?? "") \(posts?.createdDateMonth ?? "") . \(posts?.createdDateDay ?? "")"
            
            img.loadImage(path: posts?.photo  ?? "")
            icon.loadImage(path:posts?.category?.icon ?? "")
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            self.selectedBackgroundView = bgColorView
    }
    
    func configFavPostsCell(favPosts:FavPostsModel?){
        lblCategory.text = favPosts?.category?.name
        lblDisc.text = favPosts?.title
        lbllikesCount.text = "\(favPosts?.likeCount ?? 0)"
        lblCommentsCount.text = "\(favPosts?.commentsCount ?? 0)"
        lblViewsCount.text = "\(favPosts?.viewCount ?? 0)"
        lbldate.text = favPosts?.createdDate
        img.loadImage(path: favPosts?.photo  ?? "")
        icon.loadImage(path:favPosts?.category?.icon ?? "")
        if favPosts?.bookmark == true{
        imgFav.image = UIImage.init(named: "FAV")
        viewFav.backgroundColor = Colors.PrimaryColor
        }else{
        imgFav.image = UIImage.init(named: "FAV")
        }

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
    
    func configSearchPostsCell(Posts:SearchPostModel?){
        lblCategory.text = Posts?.category?.name ?? ""
        lblDisc.text = Posts?.title
        lbllikesCount.text = "\(Posts?.likeCount ?? 0)"
        lblCommentsCount.text = "\(Posts?.commentsCount ?? 0)"
        lblViewsCount.text = "\(Posts?.viewCount ?? 0)"
        lbldate.text = Posts?.createdDate
        img.loadImage(path: Posts?.photo  ?? "")
        icon.loadImage(path:Posts?.category?.icon ?? "")
        if Posts?.like == true{
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension NewsPostCell:ReuseIdentifying{}
