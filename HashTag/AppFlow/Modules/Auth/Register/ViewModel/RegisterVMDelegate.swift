//
//  RegisterVMDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS
import Swifter
extension RegisterVC:RegisterViewModelDelegate,OutputRegisterDelegate,TwitterLoginDelegate{

    func moveToWebView(type: String,url:String) {
        let vc = WebViewVC()
        vc.type = type
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func showError(error:String){
        DispatchQueue.main.async {
            self.showErrorNativeAlert(message: error)
        }
    }
    
    func registerStepOneSuccessfully() {
        let vc = SelectGenderViewController()
        vc.name = nameTF.text!
        vc.password  = passwordTF.text!
        vc.phone = phoneTF.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToLogin(){
        let vc = LoginVC()
        vc.fromRegister = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func registerStepTwoSuccessfully() {}
    
    func loginSuccessfully() {
        showSuccessAlertNativeAlert(message: Constants.messages.LoginSuccMsg)
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

            General.sharedInstance.socialLoginType = Constants.appWords.twitter
            General.sharedInstance.userImg = twProfilePic ?? ""
            if self.isConnectedToInternet() {
                guard let token = UserDefaults.standard.value(forKey: Constants.appWords.mobileToken)as? String else { return}
                let deviceID = UIDevice.current.identifierForVendor?.uuidString
                self.registerVM?.callSocialLoginApi(providerName:Constants.appWords.twitter, providerId: twId ?? "", name: twName  ?? "", email: twEmail ?? "", firebaseToken: token, device: deviceID ?? "")
            }else{
                self.showNoInternetAlert()
            }
            print("Twitter Access Token: \(self.accToken?.key ?? "Not exists")")
        }) { error in
            print("ERROR: \(error.localizedDescription)")
        }
    }

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

