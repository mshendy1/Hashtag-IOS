//
//  PrivacyViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import Foundation
protocol PrivacyViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func setHeader()
    func getPrivacySuccessfully(model:PrivacyData?)
    func getTermsSuccessfully(model:TermsModel?)
}

class PrivacyViewModel {
    weak var delegate: PrivacyViewModelDelegates?
    
    init(delegate:PrivacyViewModelDelegates) {
        self.delegate = delegate
    }
    
    
    var termsObjc:TermsModel?
    var privacyObjc:PrivacyData?

    func getTermsAPI(){
            self.delegate?.showLoading()
        SettingsNetworkManager.getTermsApi{ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    termsObjc = model?.data
                    self.delegate?.getTermsSuccessfully(model: termsObjc)
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
    
    func getPrivacyAPI(){
            self.delegate?.showLoading()
        SettingsNetworkManager.getPrivacyApi{ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    privacyObjc = model?.data
                    self.delegate?.getPrivacySuccessfully(model: privacyObjc)
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
}


extension PrivacyAndPolicyVC:PrivacyViewModelDelegates {
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
    
    
    func getTermsSuccessfully(model: TermsModel?) {
        txtView.text = model?.terms?.description.html2String
    }
    
    func getPrivacySuccessfully(model: PrivacyData?) {
        txtView.text = model?.privacy?.description.html2String
        
    }

    func setHeader(){
        self.navigationController?.isNavigationBarHidden = true
        header.delegate = self
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        if type == "privacy" {
            header.lblTitle.text = Constants.PagesTitles.privacyTitle
        }else{
            header.lblTitle.text = Constants.PagesTitles.termsTitle
        }
    }

    
}
