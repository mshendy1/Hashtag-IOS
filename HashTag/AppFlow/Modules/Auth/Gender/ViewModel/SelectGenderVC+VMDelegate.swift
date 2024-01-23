//
//  RegisterVC+VMDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

extension SelectGenderViewController:RegisterViewModelDelegate,OutputRegisterDelegate, TwitterLoginDelegate {
    func moveToLoginSheetVC() {}
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
    func registerStepOneSuccessfully() {}
    func registerStepTwoSuccessfully() {
        showSuccessAlertNativeAlert(message:Constants.messages.registerSuccessfullyMsg )
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute:{
        self.moveToSelectCategories()
        })

    }
    func swifterLogin() {}
    func moveToWebView(type: String, url: String) {}
    func loginSuccessfully() {}
    func moveToHome() { }
    func moveToLogin() {}

    
}
