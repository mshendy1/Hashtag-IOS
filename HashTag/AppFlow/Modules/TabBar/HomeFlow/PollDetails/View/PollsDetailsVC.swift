//
//  PollsDetailsVC.swift
//  HashTag
//
//  Created by Trend-HuB on 13/08/1444 AH.
//

import UIKit
import ImageSlideshow
import AVKit

class PollsDetailsVC: UIViewController,ImageSlideshowDelegate, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var tagsCollection:UICollectionView!
    @IBOutlet weak var lblcategory:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDesc:UILabel!
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var slideshow:ImageSlideshow!
    @IBOutlet weak var pageIndicator: UIPageControl!
    @IBOutlet weak var btnPlay:UIButton!
    @IBOutlet weak var viewFav:UIView!
    @IBOutlet weak var imgFav:UIImageView!
  
    let uuid = UserData.shared.deviceId ?? ""
    var loginAlertVM:LoginAlertViewModel?
    var pollsDetailsVM:PollsDetailsViewModel?
    var addToFavouritesVM:AddToFavouritesViewModel!
    var surveyID:Int!
    var videoPath:URL?
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableVC()
        scrollView.isHidden = true
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.postDetailsTitle
        self.navigationController?.isNavigationBarHidden = true
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        loginAlertVM  = LoginAlertViewModel(delegate: self)
        addToFavouritesVM = AddToFavouritesViewModel(delegate: self)
        pollsDetailsVM = PollsDetailsViewModel(delegate: self)
        if !UserDefaults.standard.isLoggedIn(){
            pollsDetailsVM?.showPolldetailsAPI(surveyID:surveyID, deviceId: self.uuid)
        }else{
            pollsDetailsVM?.showPolldetailsAPI(surveyID:surveyID, deviceId: "")
        }
    }
    
    
    func moveToLoginSheetVC(){
        let vc = LoginSheetVC()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
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
    
    @IBAction func playVideo(_ sender:UIButton) {
        let videoUrl = URL(string: pollsDetailsVM?.surveyDetails?.video ?? "")!
        print(videoUrl)
        playVideo(url: videoUrl)
    }
   
    
    @IBAction func addtoFav(_ sender:UIButton){
        if isConnectedToInternet(){
            if !UserDefaults.standard.isLoggedIn(){
                let uuid = UserData.shared.deviceId ?? ""
                addToFavouritesVM.addPollsToFavApi(id:surveyID,deviceId:uuid, type: .surveys)
            }else{
                addToFavouritesVM.addPollsToFavApi(id:surveyID,deviceId: "", type: .surveys)
            }
        }else {
            addToFavouritesVM.delegate?.connectionFailed()
        }
    }
}

extension PollsDetailsVC:AuthNavigationDelegate{
    
    func turAction() {}
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PollsDetailsVC:LoginAlertSheetDelegate{
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
        pollsDetailsVM?.showPolldetailsAPI(surveyID:surveyID, deviceId: "")
    }
    
}

extension PollsDetailsVC:ForgetPasswordDelegate{
    func didEnterdPhoneOrEmailText(textApi: String, isEmail: Bool) {
        moveToConfirmOTPVC(emailOrPhoneText: textApi, isEmail: isEmail)
    }
    func dismissAndOpenResetVC(phone: String) {
        moveToResetPasswordVC(phoneOrEmail: phone, isEmail:false)
    }
}

extension PollsDetailsVC:VerificationCodeDelegate{
    func dismissAndOpenResetVC(phoneOrEmail: String, isEmail: Bool) {
        moveToResetPasswordVC(phoneOrEmail: phoneOrEmail,isEmail:isEmail)
    }
    
    func backAndOpenForgetVC(phoneOrEmail: String, isEmail: Bool) {
        self.openForgetPassword(phoneOrEmail:phoneOrEmail,animated:false)
    }

}
extension PollsDetailsVC:ResetPasswordDelegate{
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
