//
//  SettingViewModel+delegate.swift
//  HashTag
//
//  Created by Trend-HuB on 29/07/1444 AH.
//

import Foundation
import UIKit



extension SettingVC:SettingViewModelDelegates,LoginAlertViewModelDelegates
 {
    
    func openAppStore() {}
    
    func checkIfUserLoggedIn(){}
    
    func LoginActionSuccess() {
        moveToLogin()
    }
    func logoutActionSuccess() {
        callLogoutAPI()
    }
    
    func moveToLogin(){
        let vc = LoginVC()
        General.sharedInstance.mainNav!.pushViewController(vc, animated: true)
    }
    func callLogoutAPI(){
        if isConnectedToInternet(){
            settingVM?.logoutAPI()
        }else{
           showNoInternetAlert()
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
    

    
    func moveToProfile() {
        let vc = UserProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func moveToEditeProfile() {
        let vc = UserProfileVC()
        vc.isEditting = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToMyEvents() {
        let vc = MyEventsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToContactUs(){
        let vc = ContactUsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToCommonQues() {
        let vc = CommonQeusVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func moveToWebView(type: String,url:String) {
        let vc = WebViewVC()
        vc.type = type
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    func logoutSuccessfully() {
        UserDefaults.standard.setLogout()
        UserDefaults.standard.setLoggedIn(value: false)
        self.moveToLogin()
    }

    
     func deleteUserAction(){
         // Create the alert controller
         let alertController = UIAlertController(title: "", message: Constants.messages.msgDeleteAccount, preferredStyle: .alert)
         // Create the actions
         let okAction = UIAlertAction(title: "Yes".localiz(), style: UIAlertAction.Style.default) {
             UIAlertAction in
             self.callLogoutAPI()
         }
         let cancelAction = UIAlertAction(title: "No".localiz(), style: UIAlertAction.Style.cancel) {
             UIAlertAction in
         }
         alertController.addAction(okAction)
         alertController.addAction(cancelAction)
         self.present(alertController, animated: true, completion: nil)
         
     }
    func moveToLoginSheetVC(){
        let vc = LoginSheetVC()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
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
