//
//  PollsDetailsVM+Delegates.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import Foundation
import ImageSlideshow
import AVFoundation
import UIKit
extension PollsDetailsVC:PollsDetailsViewModelDelegates,AddToFavouritesViewModelDelegates,LoginAlertViewModelDelegates{

    func showLoading() {
        startLoadingIndicator()
    }
    func killLoading() {
        stopLoadingIndicator()
    }
    func connectionFailed() {
        showNoInternetAlert()
    }
    func showError(error: String){
        showErrorNativeAlert(message: error)
    }
    func PollTapped() {}
    func openAppStore() {}
    func checkIfUserLoggedIn() {}
    
    func LoginActionSuccess() {
        moveToLogin()
    }
    func logoutActionSuccess() {}
    func moveToLogin(){
        let vc = LoginVC()
        General.sharedInstance.mainNav!.pushViewController(vc, animated: true)
    }
    func callLogoutAPI(){}
    
    func addToFavSuccessfully(id: Int, type: Types) {
        if !UserDefaults.standard.isLoggedIn(){
            pollsDetailsVM?.showPolldetailsAPI(surveyID: id, deviceId: self.uuid)
        }else{
            pollsDetailsVM?.showPolldetailsAPI(surveyID: id, deviceId:"")
        }
    }
    // Mark: -
    func addPollItemsSuccessfully(survey:PollsDetailsModel?){
        if !UserDefaults.standard.isLoggedIn(){
            pollsDetailsVM?.showPolldetailsAPI(surveyID: (survey?.id)!, deviceId: self.uuid)
        }else{
            pollsDetailsVM?.showPolldetailsAPI(surveyID: (survey?.id)!, deviceId:"")
        }
    }
    
    func getSurvaySuccessfully(survey: PollsDetailsModel?) {
        loadDetailsInView()
        if survey?.type == "four_image"{
            showBanerImgs()
        }else if survey?.type == "single_image"{
            slideshow.isHidden = true
            pageIndicator.isHidden = true
            img.loadImage(path: survey?.image ?? "")
        }else if survey?.type == "video"{
            btnPlay.isHidden = false
            let videoUrl = URL(string: survey?.video ?? "")!
        if let thumbnailImage = General.getThumbnailImage(forUrl:videoUrl as URL) {
                img.image = thumbnailImage
            }
            slideshow.isHidden = true
            pageIndicator.isHidden = true
        }
    }
    
    func loadDetailsInView(){
        let model = pollsDetailsVM?.surveyDetails
        lblTitle.text  = model?.title ?? ""
        lblDesc.text = model?.des?.htmlToString
        lblcategory.text = model?.category?.first?.name ?? ""
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        icon.loadImage(path: model?.category?.first?.icon ?? "")
        lblDate.text = "\(model?.createdAtDayNumber ?? "") \(model?.createdAtMonth ?? "") . \(model?.createdAtDay ?? "")"
        setBookMark()
        table.reloadData()
        scrollView.isHidden = false
    }

//MARK:- Slider
    func showBanerImgs(){
        var imagesInputSources = [InputSource]()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            for banner in self.pollsDetailsVM?.pollImgsArray ?? [] {
                if let imageUrl = URL(string: banner) {
                    imagesInputSources.append(SDWebImageSource(url: imageUrl))
                }
            }
            self.createSlideShow(inputSources: imagesInputSources)
        }
    }
    
    func createSlideShow(inputSources: [InputSource]) {
        slideshow.slideshowInterval = 2.0
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.pageIndicator = pageIndicator
        slideshow.delegate = self
        slideshow.layer.cornerRadius = 18
        slideshow.layer.borderWidth = 1
        slideshow.layer.borderColor = Colors.borderColor.cgColor
        slideshow.clipsToBounds = true
        slideshow.setImageInputs(inputSources)
    }

    func getThumbnailFromVideoURL(url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let asset = AVAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            do {
                let cgImage = try imageGenerator.copyCGImage(at: CMTime(seconds: 0, preferredTimescale: 1), actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                DispatchQueue.main.async {
                    completion(thumbnail)
                }
            } catch {
                print("Error generating thumbnail: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func setBookMark(){
        let fav = pollsDetailsVM?.surveyDetails?.bookmark
        if fav == true {
            imgFav.image = UIImage.init(named: "FAV")
            viewFav.backgroundColor = Colors.PrimaryColor
        }else{
            imgFav.image = UIImage.init(named: "FAV")
            viewFav.backgroundColor = .secondaryLabel
        }
    }
    
    func addToFavSuccessfully() {
        let bookmark = !(pollsDetailsVM?.surveyDetails!.bookmark)!
        pollsDetailsVM?.surveyDetails?.bookmark = bookmark
        setBookMark()
    }
    
    func moveToConfirmOTPVC(emailOrPhoneText:String,isEmail:Bool){
        let vc = ConfirmOTPVC()
        vc.delegate = self
        vc.phoneOrEmail = emailOrPhoneText
        vc.isEmail = isEmail
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func moveToResetPasswordVC(phoneOrEmail: String,isEmail:Bool){
        let vc = ResetPasswordVC()
        self.type = Constants.appWords.resetPAss
        vc.delegate = self
        vc.phoneOrEmailText = phoneOrEmail
        vc.isEmail = isEmail
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    func openForgetPassword(phoneOrEmail:String?,animated:Bool) {
        if let vc = ForgetPasswordVC.instantiateFromAppStoryboard(.forgetPassword){
            vc.phone = phoneOrEmail
            vc.delegate = self
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = self
            self.present(vc, animated: animated, completion: nil)
        }
    }
    
}


