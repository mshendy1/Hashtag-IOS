
//
//  UserProfileViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

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
    func moveToLogin()
  }

class UserProfileViewModel {
    weak var delegate: UserProfileViewModelDelegate?
    init(delegate:UserProfileViewModelDelegate?) {
        self.delegate = delegate
    }

    var userObjc:ProfilData?
    func getProfileAPI(){
            self.delegate?.showLoading()
        SettingsNetworkManager.getProfileApi{ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    userObjc = model?.data
                    
                    self.delegate?.getUserProfiledataSuccessfully(model:model?.data)
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
    
    func callEditProfileApi(parameters: [String : Any],image:UIImage?){
        self.delegate?.showLoading()
        SettingsNetworkManager.callUpdateProfileAPI(Url: "\(Environment.baseUrl)updateProfile", userImage: image, params: parameters) { (result,message)  in
            self.delegate?.killLoading()
            self.delegate?.editProfileSuccessfully()
        }
    }
}


