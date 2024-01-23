//
//  ResetPasswordVMDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

extension ResetPasswordVC:ForgetPasswordViewModelDelegate
{
   
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
    
    func sendCodeSuccessfully() {}
    
    func checkCodeSuccessfully() {}
    
    func updatePasswordSuccessfully(){
        showSuccessAlertNativeAlert(message:Constants.messages.updatPasswordMsg)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute:{
            if General.sharedInstance.fromLoginSheet == true{
                self.delegate?.openLoginSheet()
            }else{
                self.delegate?.dismissResetPassword()
            }
            
        })
    }
    
}
