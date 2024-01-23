//
//  YoutubeCell.swift
//  HashTag
//
//  Created by Trend-HuB on 22/07/1444 AH.
//

import UIKit
import youtube_ios_player_helper

class YoutubeCell: UITableViewCell {
    @IBOutlet weak var videoPlayer: YTPlayerView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var channelTitle :UILabel!
    @IBOutlet weak var channelImg:UIImageView!
    @IBOutlet weak var dateLbl:UILabel!
    @IBOutlet weak var viewsLbl:UILabel!
    @IBOutlet weak var viewsTextLbl:UILabel!

    var videoId :String?{
        didSet
        {
            videoPlayer.load(withVideoId: videoId ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        videoPlayer.delegate = self
        videoPlayer.cornerRadius = 12
        videoPlayer.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    func configCellWithModel(model:TrendYoutubeModel?){
        let arr = model?.url?.components(separatedBy: "v=")
        videoId = arr?.last
        titleLbl.text = model?.title ?? ""
     
        let viewsStr = "\(model?.statistics?.viewCount ?? "")"
        viewsLbl.text = viewsStr
        viewsTextLbl.text = Constants.appWords.viwes
        channelTitle.text = model?.channelTitle ?? ""
        channelImg.loadImage(path:model?.channelImg ?? "")
        
        dateLbl.text = "\(model?.createdDateDay ?? "") \(model?.createAtDayNumber ?? "") \(model?.createdDateMonth ?? "") . "
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
        
    }
    
}
extension YoutubeCell:ReuseIdentifying{}

extension YoutubeCell: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ videoPlayer: YTPlayerView) {
    }
}
