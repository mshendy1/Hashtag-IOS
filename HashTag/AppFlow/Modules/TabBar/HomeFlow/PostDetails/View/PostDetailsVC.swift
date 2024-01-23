//
//  PostDetailsVC.swift
//  HashTag
//
//  Created by Trend-HuB on 24/07/1444 AH.
//

import UIKit
import youtube_ios_player_helper
import WebKit
import AVKit
import ImageSlideshow

class PostDetailsVC: UIViewController,WKNavigationDelegate,ImageSlideshowDelegate, WKUIDelegate, UIViewControllerTransitioningDelegate{
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var tagsCollection:UICollectionView!
    @IBOutlet weak var commentsTable:UITableView!
    @IBOutlet weak var bttomView:UIView!
    @IBOutlet weak var lblcategory:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var imgPost:UIImageView!
    @IBOutlet weak var imgMark:UIImageView!
    @IBOutlet weak var tfComment:UITextField!
//  @IBOutlet weak var videoPlayer: YTPlayerView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDesc:UILabel!
    @IBOutlet weak var lblCommentsCount:UILabel!
    @IBOutlet weak var lblComments:UILabel!
    @IBOutlet weak var lblLikesCount:UILabel!
    @IBOutlet weak var lblViewsCount:UILabel!
    @IBOutlet weak var imgLike:UIImageView!
    @IBOutlet weak var btnLike:UIButton!
    @IBOutlet weak var btnFav:UIButton!
    @IBOutlet weak var btnPlay:UIButton!
    @IBOutlet weak var btnSend:UIButton!
    @IBOutlet weak var tableHeight:NSLayoutConstraint!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var viewFav:UIView!
    @IBOutlet weak var viewEmbeded:WKWebView!
    @IBOutlet weak var webviewHeight:NSLayoutConstraint!
    @IBOutlet weak var viewHeight:NSLayoutConstraint!
    @IBOutlet weak var viewSliderHeight:NSLayoutConstraint!
    @IBOutlet weak var viewIndecatorHeight:NSLayoutConstraint!
    @IBOutlet weak var slideshow:ImageSlideshow!
    @IBOutlet weak var pageIndicator: UIPageControl!
  
    let uuid = UserData.shared.deviceId ?? ""
    var postDetailsVM:PostDetailsViewModel!
    var addToFavouritesVM:AddToFavouritesViewModel?
    var loginAlertVM:LoginAlertViewModel?
    var postId:Int!
    var type:String?
    var video_Url:String?
    var video:String?
    var imagesCommentsArry : [String] = []
    var orginalScrollViewHeight = 0.0
    let embededId = ""
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.postDetailsTitle
        self.navigationController?.isNavigationBarHidden = true
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        bttomView.layer.cornerRadius = 20
        bttomView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        setupCollection()
        postDetailsVM = PostDetailsViewModel(delegate: self)
        loginAlertVM = LoginAlertViewModel(delegate: self)
        addToFavouritesVM = AddToFavouritesViewModel(delegate: self)
        callGetPostDetailsApi()
        slideshow.delegate = self
        viewEmbeded.uiDelegate = self
    }

    func callGetPostDetailsApi(){
        if isConnectedToInternet(){
            postDetailsVM.callGetPostDetailsApi(postId: postId,deviceId: self.uuid)
        }else{
            postDetailsVM.delegate?.connectionFailed()
        }
    }
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true) {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
            vc.player?.play() }
    }

    func moveToLoginSheetVC(){
        let vc = LoginSheetVC()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func addtoFav(_ sender:UIButton){
            if isConnectedToInternet(){
                if !UserDefaults.standard.isLoggedIn(){
                    let uuid = UserData.shared.deviceId ?? ""
                    addToFavouritesVM?.addPostsToFavApi(id: postId!, deviceId: uuid, type: .news)
                }else{
                    addToFavouritesVM?.addPostsToFavApi(id: postId!, deviceId: "", type: .news)
                }
            }else{
                addToFavouritesVM?.delegate?.connectionFailed()
            }
    }
    
    @IBAction func shareAction(_ sender:UIButton){
            let url = postDetailsVM?.postDetails?.url ?? ""
            loginAlertVM?.sharePost(url: url, presenter: self, sender: sender)
    }

    @IBAction func playAction(_sender:UIButton){
         let vc =  WebViewVC()
        vc.twitter = false
        let videoUrl = postDetailsVM.postDetails?.videoURL
        let video = postDetailsVM.postDetails?.video
        if videoUrl != "" {
         vc.url = postDetailsVM.postDetails?.videoURL
        }
         else if video != "" {
            let videoPlay = URL(string:video ?? "")!
             playVideo(url: videoPlay)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    @IBAction func addComment(_sender:UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            moveToLoginSheetVC()
        }else{
            if tfComment.text == "" {
            }else{
                tfComment.resignFirstResponder()
                if isConnectedToInternet(){
                    postDetailsVM.addCommentApi(comment: tfComment.text ?? "", postId: postId)
                    tfComment.text = ""
                }else{
                   postDetailsVM.delegate?.connectionFailed()
                }
            }
        }
    }

    @IBAction func likeTapped(_sender:UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            let uuid = UserData.shared.deviceId ?? ""
            postDetailsVM.likePostApi(id: postId, deviceId: uuid)
        }else{
            postDetailsVM.likePostApi(id: postId, deviceId: "")
        }
    }
}


extension PostDetailsVC:AuthNavigationDelegate {
    func turAction() {}
    
    func backAction() {
        NotificationCenter.default.post(name: Notification.Name("reloadCategoriesFilter"), object: nil,userInfo:nil)
        self.navigationController?.popViewController(animated: true)
    }
}

extension PostDetailsVC:LoginAlertSheetDelegate{
    func dismissAndOpenRegister(fromSheet: Bool) {
        self.dismiss(animated: true){
                let vc = RegisterVC()
                vc.fromSheet = fromSheet
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func dismissAndOpenForgetPassword() {
        self.dismiss(animated: true){
            if let vc = ForgetPasswordVC.instantiateFromAppStoryboard(.forgetPassword){
                vc.delegate = self
                vc.modalPresentationStyle = .custom
                vc.transitioningDelegate = self
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func reLoadViewController() {
        callGetPostDetailsApi()
    }
    
}

extension PostDetailsVC:ForgetPasswordDelegate{
    func didEnterdPhoneOrEmailText(textApi: String, isEmail: Bool) {
        moveToConfirmOTPVC(emailOrPhoneText: textApi, isEmail: isEmail)
    }
    func dismissAndOpenResetVC(phone: String) {
        moveToResetPasswordVC(phoneOrEmail: phone, isEmail:false)
    }
}

extension PostDetailsVC:VerificationCodeDelegate{
    func dismissAndOpenResetVC(phoneOrEmail: String, isEmail: Bool) {
        moveToResetPasswordVC(phoneOrEmail: phoneOrEmail,isEmail:isEmail)
    }
    
    func backAndOpenForgetVC(phoneOrEmail: String, isEmail: Bool) {
        self.openForgetPassword(phoneOrEmail:phoneOrEmail,animated:false)
    }

}
extension PostDetailsVC:ResetPasswordDelegate{
    func openLoginSheet() {
        self.dismiss(animated: true){
            self.moveToLoginSheetVC()
        }
    }
    
    func openLogin() {}
    
    func dismissResetPassword() {
        self.dismiss(animated: true)
    }
}
