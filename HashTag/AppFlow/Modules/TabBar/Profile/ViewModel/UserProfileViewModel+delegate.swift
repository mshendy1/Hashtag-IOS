//
//  UserProfileViewModel+delegate.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import Foundation
import UIKit

extension UserProfileVC:UserProfileViewModelDelegate{
    func openChangePassword() {
        let vc = ResetPasswordVC()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func editProfileSuccessfully() {
        callGetProfileDataAPI()
    }
    
    func getUserProfiledataSuccessfully(model: ProfilData?) {
        tfName.text = model?.user?.name ?? ""
        tfEmail.text = model?.user?.email ?? ""
        tfPhone.text = model?.user?.phone ?? ""
        lblName.text = model?.user?.name ?? ""
        lblEmail.text = model?.user?.email ?? ""
        var img = model?.user?.photo ?? ""
        if img == "" {
            userImg.image = UIImage(named: "male+")
        }else{
            userImg.loadImage(path: model?.user?.photo ?? "")
        }
        if model?.user?.genderID?.id == 0 {
            imgeGender.image = UIImage(named: "male+")
            btnGendeTypesMenue.setTitle("male".localiz(), for: .normal)
        }else{
            imgeGender.image = UIImage(named: "female-")
            btnGendeTypesMenue.setTitle("female".localiz(), for: .normal)
        }
        btnDOB.setTitle(General.sharedInstance.selectecDateOfBirth, for: .normal)
        
    }
    func setUILocalize(){
      //  btnGendeTypesMenue.setTitle(Constants.buttons.btnSlelctGender, for: .normal)
       // btnDOB.setTitle(Constants.buttons.btnDateofBirth, for: .normal)
        
        btnSave.setTitle(Constants.buttons.btnSave, for: .normal)
        btnChangePassword.setTitle(Constants.buttons.btnChangePassword, for: .normal)
        btnEdit.setTitle(Constants.buttons.btnEdit, for: .normal)
       
        if isEditting == false {
            tfName.isUserInteractionEnabled = false
            tfPhone.isUserInteractionEnabled = false
            tfEmail.isUserInteractionEnabled = false
            btnUploadImage.isUserInteractionEnabled = false
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
        showErrorAlert(message: error)
    }
    
}
