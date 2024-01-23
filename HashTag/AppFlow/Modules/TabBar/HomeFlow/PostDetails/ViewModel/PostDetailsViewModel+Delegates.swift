//
//  PostDetailsViewModel+Delegates.swift
//  HashTag
//
//  Created by Trend-HuB on 01/08/1444 AH.
//

import Foundation
import UIKit
import ImageSlideshow
import AVFoundation

extension PostDetailsVC:PostDetailsViewModelDelegates,AddToFavouritesViewModelDelegates,LoginAlertViewModelDelegates{
    func openAppStore() {}
    
    func checkIfUserLoggedIn() {}

    func LoginActionSuccess() {
        postDetailsVM?.delegate?.moveToLogin()
    }
    func logoutActionSuccess() { }
    func moveToLogin(){
        let vc = LoginVC()
        General.sharedInstance.mainNav!.pushViewController(vc, animated: true)
    }
    func likePostSuccessfully(id: Int) {
        let like = postDetailsVM.postDetails!.like
        if like == true{
            postDetailsVM.postDetails?.likeCount -= 1
        }else{
            postDetailsVM.postDetails?.likeCount += 1
        }
        postDetailsVM.postDetails?.like = !like
        self.setLike()
    }
    
    func addCommentSuccessfully() {
        // refresh api
        postDetailsVM.callGetPostDetailsApi(postId: postId,deviceId: self.uuid)
    }
    
    func getTagsSuccessfully(model: [TagModel]?) {
        tagsCollection.reloadData()
    }
    
    func getCommentsSuccessfully(model: [CommentsModel]?) {
        if model?.count == 0{
            lblComments.isHidden = true
        }else{
            lblComments.isHidden = false
        }
        self.imagesCommentsArry = []
        for comment in model ?? []{
            self.imagesCommentsArry.append(comment.user?.photo ?? "")
        }
        postDetailsVM.commentsArray = model
        setupTableVC()
        commentsTable.reloadData()
    }

    
    func setLike() {
        let isLike = postDetailsVM.postDetails?.like
        lblLikesCount.text = "\(postDetailsVM.postDetails?.likeCount ?? 0)"
        if isLike == true {
            lblLikesCount.textColor = Colors.PrimaryColor
            imgLike.tintColor = Colors.PrimaryColor
        }else{
            lblLikesCount.textColor = Colors.unSelectGray
            imgLike.tintColor = Colors.unSelectGray
        }
    }
    
    func setBookMark(){
        let fav = postDetailsVM.postDetails?.bookmark
        if fav == true {
            imgMark.image = UIImage.init(named: "FAV")
            viewFav.backgroundColor = Colors.PrimaryColor
        }else{
            imgMark.image = UIImage.init(named: "FAV")
            viewFav.backgroundColor = .secondaryLabel
        }
    }
    
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
    
    
    func addToFavSuccessfully(id: Int,type: Types) {
        postDetailsVM.callGetPostDetailsApi(postId: id,deviceId:self.uuid)
    }
    
    
     func addToFavSuccessfully() {
         let bookmark = !postDetailsVM.postDetails!.bookmark
         postDetailsVM.postDetails?.bookmark = bookmark
         setBookMark()
     }
    
    func getPostDetailsSuccessfully(model: PostDetailsData?) {
        if model?.video != "" ||  model?.videoURL != "" {
            btnPlay.isHidden = false
            imgPost.isHidden = true
            
        }else{
            btnPlay.isHidden = true
            imgPost.isHidden = false
        }
        if model?.photo == "" {
            imgPost.image = UIImage.init(named:Constants.defaultsImages.defaultPostImg)
        }else{
            imgPost.loadImage(path: model?.photo ?? "")
            imgPost.contentMode = .scaleAspectFill
            imgPost.clipsToBounds = true
        }
        if model?.gallery?.count == 0 {
            slideshow.isHidden = true
            viewSliderHeight.constant = 0
            viewIndecatorHeight.constant = 0
        }
        if model?.twitterEmbedded == "" && model?.facebookEmbedded == "" {
            viewEmbeded.isHidden = true
            webviewHeight.constant = 0
        }
        viewEmbeded.load(NSURLRequest(url: NSURL(string: "https://hashksa.co/news/\(postId!)/embedded")! as URL) as URLRequest)
        
        webviewHeight.constant = (viewEmbeded.scrollView.contentSize.height ) - 50
        self.loadViewIfNeeded()
        lblcategory.text = model?.category?.name ?? ""
        let descText = model?.desNoHtml ?? ""
        let titlText = model?.title ?? ""
        let stringFromHTML = try? NSAttributedString(data: descText.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil).string
        let trimmedString = stringFromHTML?.trimmingCharacters(in: .whitespacesAndNewlines)
        lblTitle.text = titlText.htmlToString
        lblDesc.text = trimmedString
        lblViewsCount.text = "\(model?.viewCount ?? 0)"
        lblCommentsCount.text = "\( model?.commentsCount ?? 0)"
        icon.loadImage(path: model?.category?.icon ?? "")
        
        lblDate.text = "\(model?.createAtDayNumber ?? "") \(model?.createdDateMonth ?? "") . \(model?.createdDateDay ?? "")"
        
        setLike()
        setBookMark()
        //scrollView.isHidden = false
        showBanerImgs()
    }
    //MARK:- Slider
        func showBanerImgs(){
            var imagesInputSources = [InputSource]()
            DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
             for banner in self.postDetailsVM?.postImgsArray ?? [] {
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
