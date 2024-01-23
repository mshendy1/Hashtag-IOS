//
//  SettingViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 29/07/1444 AH.
//

import Foundation
protocol SettingViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func moveToProfile()
    func logoutSuccessfully()
    func moveToMyEvents()
    func moveToContactUs()
    func moveToCommonQues()
    func moveToEditeProfile()
    func moveToLogin()
    func moveToWebView(type:String,url:String)
    func moveToConfirmOTPVC(emailOrPhoneText:String,isEmail:Bool)
    func moveToResetPasswordVC(phoneOrEmail: String,isEmail:Bool)
    func openForgetPassword(phoneOrEmail:String?,animated:Bool)
    func moveToLoginSheetVC()
}

class SettingViewModel {
    weak var delegate: SettingViewModelDelegates?
    init(delegate:SettingViewModelDelegates) {
        self.delegate = delegate
    }
    
    
    func logoutAPI(){
            self.delegate?.showLoading()
        SettingsNetworkManager.logoutApi(){ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    self.delegate?.logoutSuccessfully()
                    UserData.userLoggedOut()
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
    
}
