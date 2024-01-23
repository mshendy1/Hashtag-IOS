//
//  UserProfileViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import Foundation

import Foundation
import UIKit

 protocol UserProfileViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
    func showError(error:String)
    func connectionFailed()
    func getUserProfiledataSuccessfully(model:ProfilData?)
    func setUILocalize()
    func editProfileSuccessfully()
    func openChangePassword()
}

class UserProfileViewModel {
    weak var delegate: UserProfileViewModelDelegate?
    init(delegate:UserProfileViewModelDelegate?) {
        self.delegate = delegate
    }

    
    func getProfileAPI(){
            self.delegate?.showLoading()
        SettingsNetworkManager.getProfileApi{ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    self.delegate?.getUserProfiledataSuccessfully(model:model?.data)
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
    
    func callEditProfileApi(parameters: [String : Any],image:UIImage?){
        self.delegate?.showLoading()
        SettingsNetworkManager.callUpdateProfileAPI(Url: "\(Environment.baseUrl)edit-profile", userImage: image, params: parameters) { (result,message)  in
            self.delegate?.killLoading()
            self.delegate?.editProfileSuccessfully()
        }
    }
    

}

extension UserProfileVC: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        
           return ResetPasswordPresentationController(presentedViewController: presented, presenting: presenting)
        
    }
    
}
