//
//  ContactUsVM.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import Foundation
import Foundation
protocol ContactUsViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func getConactUsSuccessfully(model:ContactUsData?)
    func socialTapped(url:String)
    func sendRequestSuccessfully()
    func callUSTApped(phone:String)
    func sendMailToTapped(email:String)
}

class ContactUsViewModel {
    weak var delegate: ContactUsViewModelDelegates?
    
    init(delegate:ContactUsViewModelDelegates) {
        self.delegate = delegate
    }
    
    
var contactUsObjc:ContactUsData?
    
    func getContactUsAPI(){
            self.delegate?.showLoading()
        SettingsNetworkManager.getContactUsApi{ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    contactUsObjc = model?.data
                    self.delegate?.getConactUsSuccessfully(model:contactUsObjc)
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
    
    func sendRequestAPI(email: String, device: String, desc: String){
            self.delegate?.showLoading()
        SettingsNetworkManager.sendContactUsRequestApi(email: email, device: device, desc: desc){ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    self.delegate?.sendRequestSuccessfully()
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
}
