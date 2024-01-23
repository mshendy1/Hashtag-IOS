//
//  IntroViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 09/11/1444 AH.
//


import Foundation

protocol IntroViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func skipToHome()
}

class IntroViewModel {
    weak var delegate: IntroViewModelDelegate?
    init(delegate:IntroViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func guestUserStoreApi(firebaseToken: String,deviceId:String){
        self.delegate?.showLoading()
        AuthNetworkManger.getGuestUserApi(firebaseToken:firebaseToken,device:deviceId) { (loginModel, error) in
            self.delegate?.killLoading()
            if (loginModel != nil) {
                self.delegate?.skipToHome()
                    General.sharedInstance.socialLoginType = "guest"
                UserDefaults.standard.setGuest(value: true)
            }else if (error != nil)
            {
                self.delegate?.showError(error:Constants.messages.msgGuestFaild)
            }
        }
    }
    
    
    
}
