//
//  SplashViewModel+Delegate.swift
//  HashTag
//
//  Created by Trend-HuB on 01/11/1444 AH.
//

import Foundation
//
//  LoginViewModel.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

protocol SplashViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func refreshSuccessfully()
}

class SplashViewModel {
    weak var delegate: SplashViewModelDelegate?
    init(delegate:SplashViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func callRefreshFCMTokenApi(id: Int,fcmToken: String){
        self.delegate?.showLoading()
        AuthNetworkManger.refreshFCMTokenApi(id: id, fcmToken: fcmToken){ (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.refreshSuccessfully()
                
            }else if (error != nil)
            {
               // self.delegate?.showError(error:Constants.messages.msgLoginFaild)
            }
        }
    }
    
    
}

