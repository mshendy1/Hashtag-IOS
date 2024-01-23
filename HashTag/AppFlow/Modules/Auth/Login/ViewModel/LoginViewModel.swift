//
//  LoginViewModel.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
}
protocol LoginOutputDelegates:AnyObject{
    func openForgetPassword(phoneOrEmail:String?,animated:Bool)
    func moveToRegister()
    func securePassword()
    func moveToConfirmOTPVC(emailOrPhoneText:String,isEmail:Bool)
    func moveToResetPasswordVC(phoneOrEmail: String,isEmail:Bool)
    func moveToRegisterTapped()
    func loginSuccessfully()

}
protocol LoginTwitterDelegates:AnyObject{
    func swifterLogin()
    func moveToHome()
}


class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
    weak var outputDelegate:LoginOutputDelegates?
    weak var twitterDelegate:LoginTwitterDelegates?
    init(delegate:LoginViewModelDelegate?,outputDelegate:LoginOutputDelegates?,twitterDelegate:LoginTwitterDelegates?) {
        self.delegate = delegate
        self.outputDelegate = outputDelegate
        self.twitterDelegate = twitterDelegate
    }

    
    func callLoginApi(name: String,password: String,firebaseToken: String,device:String){
        self.delegate?.showLoading()
        AuthNetworkManger.loginApi(name: name, password: password, firebaseToken: firebaseToken,deviceId:device) { (loginModel, error) in
            self.delegate?.killLoading()
            if (loginModel != nil) {
                self.outputDelegate?.loginSuccessfully()
                let myObject = loginModel?.data?.data
                do {
                    let jsonData = try JSONEncoder().encode(myObject)
                    UserData.shared.saveUser(from:jsonData)
                    UserDefaults.standard.setGuest(value: false)
                    UserDefaults.standard.setLoggedIn(value: true)
                    General.sharedInstance.socialLoginType = "user"
                } catch {
                    
                    print(error.localizedDescription)
                }
            }else if (error != nil)
            {
                self.delegate?.showError(error:Constants.messages.msgLoginFaild)
            }
        }
    }
    

    func callSocialLoginApi(providerName:String,providerId:String,name:String,email:String,firebaseToken:String,deviceId:String){
        self.delegate?.showLoading()
        AuthNetworkManger.SocialLoginApi(providerName:providerName,providerId:providerId,name:name,email:email,device:deviceId) { (loginModel, error) in
            self.delegate?.killLoading()
            if (loginModel != nil) {
                    self.outputDelegate?.loginSuccessfully()
                DispatchQueue.main.async {
                    let myObject = loginModel?.data?.data!
                    do {
                        let jsonData = try JSONEncoder().encode(myObject)
                        UserData.shared.saveUser(from:jsonData)
                        UserDefaults.standard.setGuest(value: false)
                        UserDefaults.standard.setLoggedIn(value: true)
                        UserDefaults.standard.setName(value: myObject?.name ?? "")
                        UserDefaults.standard.setEmailId(value: myObject?.email ?? "")
                        General.sharedInstance.socialLoginType = providerName
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }else if (error != nil)
            {
                self.delegate?.showError(error:Constants.messages.msgLoginFaild)
            }
        }
    }
    
}
