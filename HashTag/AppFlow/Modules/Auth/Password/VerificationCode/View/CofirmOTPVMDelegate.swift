//
//  CofirmOTPVMDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

extension ConfirmOTPVC:ForgetPasswordViewModelDelegate
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
    
    func sendCodeSuccessfully() {
        runTimer()
    }
    func updatePasswordSuccessfully() {
        
    }
    
    func checkCodeSuccessfully() {
        self.dismiss(animated: true){
            self.delegate?.dismissAndOpenResetVC(phoneOrEmail:self.phoneOrEmail ?? "",isEmail:self.isEmail ?? false )
        }
    }
    
}
