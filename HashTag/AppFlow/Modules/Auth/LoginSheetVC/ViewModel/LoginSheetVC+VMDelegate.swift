//
//  LoginVC+VMDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS
//import GoogleSignIn
import Swifter
import NotificationBannerSwift
extension LoginSheetVC:LoginSheetVMlDelegate{
    func showLoading() {startLoadingIndicator()}
    func killLoading() {stopLoadingIndicator()}
    func connectionFailed() { showNoInternetAlert()}
    func showError(error:String) {showErrorNativeAlert(message: error)}

}

extension LoginSheetVC : LoginSheetOutputDelegates{
    
    func moveToRegisterTapped() {
        if fromRegister == true{
          // if open frome login sheet vc you will back to loginSheetVC by delegation
        }else{
            moveToRegister()
        }
    }
    
    func openForgetPassword(phoneOrEmailText:String?,animated:Bool) {
        self.dismiss(animated: true){
            if let vc = ForgetPasswordVC.instantiateFromAppStoryboard(.forgetPassword){
                vc.phone = phoneOrEmailText
                vc.delegate = self
                vc.modalPresentationStyle = .custom
                vc.transitioningDelegate = self
                self.present(vc, animated: animated, completion: nil)
            }
        }
    }
    
    func moveToRegister(){
        let vc = RegisterVC()
        vc.fromLogin = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func securePassword(){
        if self.btnPassSecure.image(for: .normal) == UIImage(systemName: "eye.slash.fill") {
            self.btnPassSecure.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            self.passwordTF.isSecureTextEntry = false
        }
        else {
            self.passwordTF.isSecureTextEntry = true
            self.btnPassSecure.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    func moveToConfirmOTPVC(phoneOrEmailText:String,isEmail:Bool){
        let vc = ConfirmOTPVC()
        vc.delegate = self
        vc.phoneOrEmail = phoneOrEmailText
        vc.isEmail = isEmail
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func moveToResetPasswordVC(phoneOrEmail: String,isEmail:Bool){
        loginSuccessfully()
        DispatchQueue.main.async {
            let vc = ResetPasswordVC()
            self.type = Constants.appWords.resetPAss
            vc.delegate = self
            vc.phoneOrEmailText = phoneOrEmail
            vc.isEmail = isEmail
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
   
    func loginSuccessfully() {
        self.delegate?.reLoadViewController()
        self.dismiss(animated: true)
    }
    
    func moveToHome(){}
    
    func getUserProfile() {
        self.swifter.verifyAccountCredentials(includeEntities: false, skipStatus: false, includeEmail: true, success: { json in
            // Twitter Id
            let twId = json["id_str"].string
            let twitterHandle = json["screen_name"].string
            let twName = json["name"].string
            let twEmail = json["email"].string
            let twProfilePic = json["profile_image_url_https"].string?.replacingOccurrences(of: "_normal", with: "", options: .literal, range:nil)
           
            UserDefaults.standard.setUserImage(value: twProfilePic ?? "")
            UserDefaults.standard.setEmailId(value: twEmail ?? "")
            UserDefaults.standard.setName(value: twName ?? "")

            General.sharedInstance.socialLoginType = "twitter"
            General.sharedInstance.userImg = twProfilePic ?? ""
            if self.isConnectedToInternet() {
                guard let token = UserDefaults.standard.value(forKey: "mobileToken")as? String else { return}
                let deviceID = UIDevice.current.identifierForVendor?.uuidString
                self.logiVM?.callSocialLoginApi(providerName:Constants.appWords.twitter, providerId: twId ?? "", name: twName  ?? "", email: twEmail ?? "", firebaseToken: token, deviceId: deviceID ?? "")
            }else{
                self.showNoInternetAlert()
            }
            print("Twitter Access Token: \(self.accToken?.key ?? "Not exists")")
        }) { error in
            print("ERROR: \(error.localizedDescription)")
        }
    }


}

extension LoginSheetVC:LoginSheetTwitterDelegates {
    func swifterLogin(){
        self.swifter = Swifter(consumerKey: Constants.TwitterConstants.consumerKey, consumerSecret: Constants.TwitterConstants.consumerSecret)
        self.swifter.authorize(withCallback: URL(string: Constants.TwitterConstants.callbackUrl)!, presentingFrom: self, success: { accessToken, _ in
            self.accToken = accessToken
            self.getUserProfile()
        }, failure: { _ in
            print("ERROR: Trying to authorize")
        })
    }

    }
