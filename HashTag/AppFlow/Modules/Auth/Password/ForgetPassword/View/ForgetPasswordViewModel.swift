//
//  ForgetPasswordViewModel.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

protocol ForgetPasswordViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func sendCodeSuccessfully()
    func checkCodeSuccessfully()
    func updatePasswordSuccessfully()

    
}

class ForgetPasswordViewModel {
    weak var delegate: ForgetPasswordViewModelDelegate?
    init(delegate:ForgetPasswordViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func callSendCodeApi(phone: String,email:String){
        self.delegate?.showLoading()
        AuthNetworkManger.sendCodeApi(phone: phone,email:email) { (model, error) in
            
            self.delegate?.killLoading()
            
            if (model != nil) {
                self.delegate?.sendCodeSuccessfully()
                
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
//    
//    func callSendCodeToEmailApi(phone: String,email:String){
//        self.delegate?.showLoading()
//        AuthNetworkManger.emailSendCodeApi(phone: phone,email:email) { (model, error) in
//            
//            self.delegate?.killLoading()
//            
//            if (model != nil) {
//                self.delegate?.sendCodeSuccessfully()
//                
//            }else if (error != nil)
//            {
//                self.delegate?.showError(error: error?.localizedDescription ?? "")
//            }
//        }
//    }
 
    
    func callCheckCodeApi(code:String,phone: String,email:String){
        self.delegate?.showLoading()
        AuthNetworkManger.checkCodeApi(code: code, phone: phone,email:email) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.checkCodeSuccessfully()
                
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    
    
    func callUpdatePasswordApi(password:String,email:String,phone: String,passwordConfirmation:String){
        self.delegate?.showLoading()
        AuthNetworkManger.updatePasswordApi(password: password,email:email, phone: phone, passwordConfirmation: passwordConfirmation) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.updatePasswordSuccessfully()
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    
}
