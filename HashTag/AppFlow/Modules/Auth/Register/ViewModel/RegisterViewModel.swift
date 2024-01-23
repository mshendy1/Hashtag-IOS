//
//  RegisterViewModel.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation
import Swifter

protocol RegisterViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func registerStepOneSuccessfully()
    func registerStepTwoSuccessfully()
}
protocol TwitterLoginDelegate:AnyObject{
    func swifterLogin()
}
protocol OutputRegisterDelegate:AnyObject{
    func moveToWebView(type: String,url:String)
    func loginSuccessfully()
    func moveToHome()
    func moveToLogin()
   
}


class RegisterViewModel {
    weak var twitterDelegate: TwitterLoginDelegate?
    weak var delegate: RegisterViewModelDelegate?
    weak var outputDelegate: OutputRegisterDelegate?

    init(twitterDelegate:TwitterLoginDelegate?,delegate:RegisterViewModelDelegate?,outputDelegate:OutputRegisterDelegate?) {
        self.twitterDelegate = twitterDelegate
        self.outputDelegate = outputDelegate
        self.delegate = delegate
    }

    
    func callRegisterStepOneApi(name: String,email:String,password:String,phone:String,device:String){
        self.delegate?.showLoading()
        AuthNetworkManger.registerStepOneApi(name: name,email:email, password: password,  phone: phone, deviceId: device) { (data , error) in
            self.delegate?.killLoading()
            do{
                if error == nil && data == nil {
                    print("Connection failed")
                    self.delegate?.connectionFailed()
                } else if (error != nil)  {
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }else if (data?.status == false){
                    self.delegate?.showError(error:data?.message ?? "")
                }else if (data?.status == true){
                    let userData = data?.data
                            let jsonData = try JSONEncoder().encode(userData)
                            UserData.shared.saveUser(from:jsonData)
                            UserDefaults.standard.setLoggedIn(value: true)
                            UserDefaults.standard.setGuest(value: false)
                            General.sharedInstance.socialLoginType = "user"
                            print(jsonData)
                            self.delegate?.registerStepOneSuccessfully()
                }
            }catch{
                print("Register test error")
            }
            
        }
    }
    
    func callRegisterStepTwoApi(genderId: Int,dateOfBirth:String) {
        self.delegate?.showLoading()
        AuthNetworkManger.registerStepTwoApi(genderId: genderId, dateOfBirth: dateOfBirth) { (registerModel, error) in
            self.delegate?.killLoading()
            if (registerModel != nil) {
                self.delegate?.registerStepTwoSuccessfully()
                UserDefaults.standard.setGuest(value: false)
                let myObject = registerModel?.data?.data
                do {
                    let jsonData = try JSONEncoder().encode(myObject)
                    UserData.shared.saveUser(from:jsonData)
                    print(jsonData)
                } catch {
                    print(error.localizedDescription)
                }
                General.sharedInstance.userName = registerModel?.data?.data?.name ?? ""
                General.sharedInstance.userEmail = registerModel?.data?.data?.email ?? ""
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    func callSocialLoginApi(providerName:String,providerId:String,name:String,email:String,firebaseToken:String,device:String){
        self.delegate?.showLoading()
        AuthNetworkManger.SocialLoginApi(providerName:providerName,providerId:providerId,name:name,email:email, device: device) { (loginModel, error) in
            self.delegate?.killLoading()
            if (loginModel != nil) {
                self.outputDelegate?.loginSuccessfully()
                
                let myObject = loginModel?.data?.data!
                do {
                    let jsonData = try JSONEncoder().encode(myObject)
                    UserData.shared.saveUser(from:jsonData)
                    UserDefaults.standard.setLoggedIn(value: true)
                    UserDefaults.standard.setGuest(value: false)
                    General.sharedInstance.socialLoginType = providerName
                    print(jsonData)
                    General.sharedInstance.userName = myObject?.name ?? ""
                    General.sharedInstance.userEmail = myObject?.email ?? ""
                } catch {
                    print(error.localizedDescription)
                }
               
            }else if (error != nil)
            {
                self.delegate?.showError(error:Constants.messages.msgLoginFaild)
            }
        }
    }

}




//let myObject = registerModel?.data?.data
//do {
//    if registerModel?.status == true{
//        let jsonData = try JSONEncoder().encode(myObject)
//        UserData.shared.saveUser(from:jsonData)
//        UserDefaults.standard.setLoggedIn(value: true)
//        General.sharedInstance.socialLoginType = "user"
//        print(jsonData)
//        self.delegate?.registerStepOneSuccessfully()
//    }else{
//        self.delegate?.showError(error: registerModel?.message ?? "dddd")
//    }
//} catch {
//    self.delegate?.showError(error: error.localizedDescription )
//}
