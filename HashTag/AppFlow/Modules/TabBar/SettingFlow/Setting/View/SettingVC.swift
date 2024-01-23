//
//  SettingVC.swift
//  HashTag
//
//  Created by Trend-HuB on 29/07/1444 AH.
//

import UIKit

class SettingVC: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var userImg:UIImageView!
    @IBOutlet weak var tableHeight:NSLayoutConstraint!
    @IBOutlet weak var viewHeight:NSLayoutConstraint!
    @IBOutlet weak var lblEmail:UILabel!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblLogout:UILabel!
    @IBOutlet weak var btnLogout:UIButton!
    @IBOutlet weak var imgLogout:UIImageView!
    @IBOutlet weak var btnEdite:UIButton!
    
    var settingVM:SettingViewModel?
    var loginAlertVM:LoginAlertViewModel?
    var userData = UserData.shared.userDetails
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        header.delegate = self
        header.img.isHidden = true
        header.btnBack.isHidden = true
        header.switchNotificattion.isHidden = true
        header.switchNotificattion.isHidden = true
        header.lblTitle.text = Constants.PagesTitles.settingsTitle
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userData = UserData.shared.userDetails
        settingVM = SettingViewModel(delegate: self)
        loginAlertVM = LoginAlertViewModel(delegate: self)
        setupTable()
    }

}

extension SettingVC:AuthNavigationDelegate{
    func backAction() {}
    func turAction() {}
}



extension SettingVC:LoginAlertSheetDelegate{
    func dismissAndOpenRegister(fromSheet:Bool) {
        self.dismiss(animated: true){
                let vc = RegisterVC()
                vc.fromSheet = fromSheet
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func reLoadViewController() {
        viewWillAppear(true)
    }
  
    func dismissAndOpenForgetPassword() {
        self.dismiss(animated: true){
            if let vc = ForgetPasswordVC.instantiateFromAppStoryboard(.forgetPassword){
                vc.delegate = self
                vc.modalPresentationStyle = .custom
                vc.transitioningDelegate = self
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

extension SettingVC:ForgetPasswordDelegate{
    func didEnterdPhoneOrEmailText(textApi: String, isEmail: Bool) {
        moveToConfirmOTPVC(emailOrPhoneText: textApi, isEmail: isEmail)
    }
    func dismissAndOpenResetVC(phone: String) {
        moveToResetPasswordVC(phoneOrEmail: phone, isEmail:false)
    }
}

extension SettingVC:VerificationCodeDelegate{
    func dismissAndOpenResetVC(phoneOrEmail: String, isEmail: Bool) {
        moveToResetPasswordVC(phoneOrEmail: phoneOrEmail,isEmail:isEmail)
    }
    
    func backAndOpenForgetVC(phoneOrEmail: String, isEmail: Bool) {
        self.openForgetPassword(phoneOrEmail:phoneOrEmail,animated:false)
    }

}
extension SettingVC:ResetPasswordDelegate{
    func openLogin(){
        self.dismiss(animated: true){}
    }
    func openLoginSheet(){
        self.dismiss(animated: true){
            self.moveToLoginSheetVC()
        }

    }
    func dismissResetPassword() {
        self.dismiss(animated: true)
    }
}
