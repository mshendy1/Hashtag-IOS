//
//  CommonQeusVM+Delegates.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import Foundation

extension CommonQeusVC:CommonQeusVMDelegates{

    
    func showLoading() {
        startLoadingIndicator()
    }
    
    func killLoading() {
        stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func showError(error: String){
        showErrorNativeAlert(message: error)
    }

    func getCommomQuesSuccessfully(model: [QuesModel]?) {
        setupTableVC()
    }
    
}

