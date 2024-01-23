//
//  ContactUsVM+Delegates.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import Foundation
import UIKit
import MessageUI

extension ContactUsVC:ContactUsViewModelDelegates{
    func callUSTApped(phone: String) {
        if let url = URL(string: "tel://\(phone)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func sendMailToTapped(email:String){
        let appURL = URL(string: "\(email)")!

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(appURL)
        }

    }

    
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
    func getConactUsSuccessfully(model: ContactUsData?) {
        setupCollection()
        if model?.email != ""{
            emailLbl.text = model?.email ?? ""
        }else{
            emailLbl.isHidden = true
            emailImg.isHidden = true
        }
        if model?.phone != ""{
            phoneLbl.text = model?.phone ?? ""
        }else{
            phoneImg.isHidden = true
            phoneLbl.isHidden = true
        }
    }
    func socialTapped(url:String){
        let vc = WebViewVC()
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendRequestSuccessfully() {
        showSuccessAlertNativeAlert(message: Constants.messages.sendcontactUsMsg)
        tvDesc.text = ""
        self.placeHolderLbl.isHidden = false
    }
    
}
