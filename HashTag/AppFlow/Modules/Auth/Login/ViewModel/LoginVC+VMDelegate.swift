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
extension LoginVC:LoginViewModelDelegate{
  
    func showLoading() {startLoadingIndicator()}
    func killLoading() {stopLoadingIndicator()}
    func connectionFailed() { showNoInternetAlert()}
    func showError(error:String) {showErrorNativeAlert(message: error)}

}

extension LoginVC : LoginOutputDelegates{
    
    func moveToRegisterTapped() {
        if fromRegister == true{
        self.navigationController?.popViewController(animated: true)
        }else{
            moveToRegister()
        }
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
    func loginSuccessfully() {
       showSuccessAlertNativeAlert(message: Constants.messages.LoginSuccMsg.localiz())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute:{
            self.moveToHome()
        })
    }

    func moveToHome(){
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SSCustomTabBarViewController") as! SSCustomTabBarViewController
        let customTabBar = vc.tabBar as? SSCustomTabBar
        customTabBar?.customeLayout()

        if LanguageManager.shared.isRightToLeft {
            vc.lang = "ar"
        }
        General.sharedInstance.mainNav = self.navigationController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

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

extension LoginVC:LoginTwitterDelegates {
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
