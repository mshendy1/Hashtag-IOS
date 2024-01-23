//
//  LoginViewController.swift
//  HashTag
//
//  Created by Mohamed Shendy on 05/02/2023.
//

import UIKit
import FacebookCore
import LanguageManager_iOS
import FBSDKLoginKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
//import TwitterKit
import Swifter
//import TwitterCore
import SafariServices

class LoginVC: UIViewController //,TWTRComposerViewControllerDelegate
   {
    @IBOutlet var header: LoginHeader!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var btnPassSecure:UIButton!
    @IBOutlet var btnForrgetPass:UIButton!
    @IBOutlet var twitterView:UIView!
    var fromLogout = false
    var fromRegister = false
    var type = ""
    var userimageURL = ""
    var userName = ""
    var firstName = ""
    var email = ""
    //var phone = ""
    var introVM:IntroViewModel?
    var logiVM:LoginViewModel?
    var twitterId = ""
    var swifter: Swifter!
    var accToken: Credential.OAuthAccessToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        header.delegate = self
        self.navigationController?.isNavigationBarHidden =  true
        logiVM = LoginViewModel(delegate: self, outputDelegate: self, twitterDelegate: self)
        introVM = IntroViewModel(delegate: self)
        setupGoogleSignin()
//        nameTF.text = "shendy@gmail.com"
//        passwordTF.text = "123456"
    }

    @IBAction func loginAction() {
        CallLoginApi()
    }
    @IBAction func navigateToRegisterTapped(){
        logiVM?.outputDelegate?.moveToRegisterTapped()
        
    }
    @IBAction func forgetPasswordAction(){
        openForgetPassword(phoneOrEmail:nil,animated:true)
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

extension LoginVC:ForgetPasswordDelegate{
    func dismissLoginSheetVC() {
        self.dismiss(animated: true)
    }
    
    func didEnterdPhoneOrEmailText(textApi: String, isEmail: Bool) {
        moveToConfirmOTPVC(emailOrPhoneText: textApi, isEmail: isEmail)
    }
    
    func dismissAndOpenResetVC(phone: String) {
        moveToResetPasswordVC(phoneOrEmail: phone, isEmail:false)
    }
}

extension LoginVC:VerificationCodeDelegate{
    func dismissAndOpenResetVC(phoneOrEmail: String, isEmail: Bool) {
        moveToResetPasswordVC(phoneOrEmail: phoneOrEmail,isEmail:isEmail)
    }
    
    func backAndOpenForgetVC(phoneOrEmail: String, isEmail: Bool) {
        General.sharedInstance.fromLoginSheet = false
        self.openForgetPassword(phoneOrEmail:phoneOrEmail,animated:false)
    }

}
extension LoginVC:ResetPasswordDelegate{
    func openLoginSheet() {}
    
    func openLogin() {}
    func dismissResetPassword() {
        self.dismiss(animated: true)
    }
    
}


//MARK: -
extension LoginVC: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if type == Constants.appWords.resetPAss{
           return ResetPasswordPresentationController(presentedViewController: presented, presenting: presenting)
        }else{
           return PresentationController(presentedViewController: presented, presenting: presenting)
        }
    }
    
}



extension LoginVC:LoginHeaderDelegate,IntroViewModelDelegate{
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

extension LoginVC : SFSafariViewControllerDelegate{}
