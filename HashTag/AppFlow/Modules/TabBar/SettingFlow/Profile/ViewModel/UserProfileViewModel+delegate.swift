//
//  UserProfileViewModel+delegate.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import Foundation
import UIKit

extension UserProfileVC:UserProfileViewModelDelegate{
 
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
    
    func openChangePassword() {
        let vc = ResetPasswordVC()
        vc.delegate = self
        vc.phoneOrEmailText = UserProfileVM?.userObjc?.user?.phone
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func editProfileSuccessfully() {
        callGetProfileDataAPI()
        lblName.text = General.sharedInstance.userName
        lblEmail.text = General.sharedInstance.userEmail
    }
    
    func getUserProfiledataSuccessfully(model: ProfilData?){
        tfName.text = model?.user?.name ?? ""
        tfEmail.text = model?.user?.email ?? ""
        tfPhone.text = model?.user?.phone ?? ""
        lblName.text = model?.user?.name ?? ""
        lblEmail.text = model?.user?.email ?? ""
        if selectedImage == nil{
            let img =  UserProfileVM.userObjc?.user?.photo ?? ""
            let socialImg = UserDefaults.standard.getUserImage()
           let socialLoginType = General.sharedInstance.socialLoginType
            
             if UserDefaults.standard.isLoggedIn() && img != ""{
                userImg.loadImage(path: img,placeHolderImage: UIImage(named: "man"))
            }else if socialLoginType != "user" && socialLoginType != "guest" && socialImg != ""{
                userImg.loadImage(path:socialImg,placeHolderImage: UIImage(named: "man"))
            }else{
                userImg.image = UIImage.init(named: "user")
            }
        }
        if model?.user?.genderID?.id == 0{
            btnGendeTypesMenue.setTitle(Constants.appWords.selectGender, for: .normal)
            imgeGender.image = UIImage(named: "gender")
            selectedGenderId = 0
        }
       else if model?.user?.genderID?.id == 1 {
            let genderImg = General.sharedInstance.gendeImgs[0]
            btnGendeTypesMenue.setTitle("male".localiz(), for: .normal)
            imgeGender.image = UIImage(named: genderImg)
            selectedGenderId = model?.user?.genderID?.id
        }else{
            let genderImg = General.sharedInstance.gendeImgs[1]
            imgeGender.image = UIImage(named: genderImg)
            btnGendeTypesMenue.setTitle("female".localiz(), for: .normal)
            selectedGenderId = model?.user?.genderID?.id
        }
        var dateOfbirth = ""

        if !UserDefaults.standard.isLoggedIn(){
            btnDOB.setTitle(Constants.appWords.selectGender, for: .normal)
        }else{
            dateOfbirth = UserProfileVM.userObjc?.user?.dateOfBirth ?? ""
            btnDOB.setTitle(dateOfbirth, for: .normal)
            selectecDateOfBirth = model?.user?.dateOfBirth
        }
    }
    
    func setUILocalize(){
        btnChangePassword.setTitle(Constants.buttons.btnChangePassword, for: .normal)
            tfName.isUserInteractionEnabled = true
            tfPhone.isUserInteractionEnabled = true
            tfEmail.isUserInteractionEnabled = true
            btnUploadImage.isUserInteractionEnabled = true
            btnDOB.isUserInteractionEnabled = true
            btnGendeTypesMenue.isUserInteractionEnabled = true
            btnChangePassword.isUserInteractionEnabled = true
            btnSave.isHidden = false
            btnChangePassword.isHidden = false
            viewEditePhoto.isHidden = false
    }
    func moveToLogin() {
        let vc = LoginVC()
        UINavigationController(rootViewController: vc).popToRootViewController(animated: true)
    }
    

    
}
extension UserProfileVC:ResetPasswordDelegate{
    func openLogin() {}
    func openLoginSheet(){}
    func dismissResetPassword() {
        self.dismiss(animated:true)
    }
}

extension UserProfileVC: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
           return ResetPasswordPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
