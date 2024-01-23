//
//  ForgetPasswordVMDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

extension ForgetPasswordVC:ForgetPasswordViewModelDelegate{
   
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
        showErrorNativeAlert(message: error)
    }
    
    func sendCodeSuccessfully() {
        self.dismiss(animated: true){
            if self.checkIsEmail == true{
                self.delegate?.didEnterdPhoneOrEmailText(textApi: self.userTF.text!, isEmail: true)
            }else{
                self.delegate?.didEnterdPhoneOrEmailText(textApi: self.userTF.text!, isEmail: false)
            }
        }
    }
    
    func checkCodeSuccessfully() {}
    func updatePasswordSuccessfully() {}
    
}
