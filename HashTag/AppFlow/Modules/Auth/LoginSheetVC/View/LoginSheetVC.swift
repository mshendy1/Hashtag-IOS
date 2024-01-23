//
//  LoginSheetVC.swift
//  HashTag
//
//  Created by Trend-HuB on 14/02/1445 AH.
//

import Foundation
import UIKit
import FacebookCore
import LanguageManager_iOS
import FBSDKLoginKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import Swifter
import SafariServices
//Protocol
protocol LoginAlertSheetDelegate {
    func dismissAndOpenRegister(fromSheet:Bool)
    func reLoadViewController()
    func dismissAndOpenForgetPassword()
}
class LoginSheetVC: UIViewController  {
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var btnPassSecure:UIButton!
    @IBOutlet var btnForrgetPass:UIButton!
    var delegate: LoginAlertSheetDelegate?
    var fromLogout = false
    var fromRegister = false
    var type = ""
    var userimageURL = ""
    var userName = ""
    var firstName = ""
    var email = ""
    var phone = ""
    var introVM:IntroViewModel?
    var logiVM:LoginSheetViewModel?
    var twitterId = ""
    var swifter: Swifter!
    var accToken: Credential.OAuthAccessToken?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden =  true
        logiVM = LoginSheetViewModel(delegate: self, outputDelegate: self, twitterDelegate: self)
        introVM = IntroViewModel(delegate: self)
        setupGoogleSignin()
        
//        nameTF.text = "shendy@gmail.com"
//        passwordTF.text = "123456"
        
        General.sharedInstance.fromLoginSheet = true
    }

    @IBAction func loginAction() {
        CallLoginApi()
    }
    @IBAction func dismissView() {
        dismiss(animated: true)
    }
    @IBAction func navigateToRegisterTapped(){
        self.delegate?.dismissAndOpenRegister(fromSheet: true)
    }
    @IBAction func forgetPasswordAction(){
        self.delegate?.dismissAndOpenForgetPassword()
    }
    @IBAction func securePasswordAction(){
        securePassword()
    }
    @IBAction func ClickOnBtnGoogleLogin(_ sender: Any){GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func ClickOnBtnFacebook(_ sender: Any){
        facebookLogin()
    }
    @IBAction func ClickOnBtnTwitterLogin(_ sender: Any){
        logiVM?.twitterDelegate?.swifterLogin()
    }

    @IBAction func appleRegistrationActionButton(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
        handleAuthorizationAppleIDButtonPress()
        }else {
            AlertsManager.showAlert(withTitle: "", message: Constants.messages.internetError, viewController: self,actionHandler:{_ in
                self.navigationController?.popViewController(animated: true)
            } )
        }
    }
    
    func CallLoginApi(){
        if nameTF.text == "" || passwordTF.text == "" {
            showErrorAlert(message:Constants.messages.fillEmptyFields)
        }else{
            if isConnectedToInternet(){
                guard let token = UserDefaults.standard.value(forKey: "mobileToken")as? String else { return}
                self.view.endEditing(true)
                let uuid = UserData.shared.deviceId ?? ""
                logiVM?.callLoginApi(name: nameTF.text!, password: passwordTF.text!, firebaseToken: token, device: uuid)
            }else{
                logiVM?.delegate?.connectionFailed()
            }
        }
    }
    
    func  setupGoogleSignin(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
  }

extension LoginSheetVC:ForgetPasswordDelegate{

    func didEnterdPhoneOrEmailText(textApi: String, isEmail: Bool) {
        moveToConfirmOTPVC(phoneOrEmailText: textApi, isEmail: isEmail)
    }
    
}

extension LoginSheetVC:VerificationCodeDelegate{

    func dismissAndOpenResetVC(phoneOrEmail: String,isEmail:Bool) {
        moveToResetPasswordVC(phoneOrEmail: phoneOrEmail, isEmail: isEmail)
    }
    
    func backAndOpenForgetVC(phoneOrEmail: String,isEmail:Bool) {
        self.openForgetPassword(phoneOrEmailText:phoneOrEmail,animated:false)
    }
}
extension LoginSheetVC:ResetPasswordDelegate{
    func openLoginSheet() {}
    func openLogin() {}
    func dismissResetPassword() {self.dismiss(animated: true) }
}


//MARK: -
extension LoginSheetVC: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if type == Constants.appWords.resetPAss{
           return ResetPasswordPresentationController(presentedViewController: presented, presenting: presenting)
        }else{
           return PresentationController(presentedViewController: presented, presenting: presenting)
        }
    }
    
}



extension LoginSheetVC:IntroViewModelDelegate{
    func skipToHome() {
        logiVM?.twitterDelegate?.moveToHome()
    }
    
    func Skip() {
        let uuid = UserData.shared.deviceId ?? ""
        guard let token = UserDefaults.standard.value(forKey: Constants.appWords.mobileToken)as? String else { return}
        if isConnectedToInternet(){
            introVM?.guestUserStoreApi(firebaseToken: token, deviceId: uuid)
        }else{
            introVM?.delegate?.connectionFailed()
        }
    }
}

extension LoginSheetVC : SFSafariViewControllerDelegate{}
