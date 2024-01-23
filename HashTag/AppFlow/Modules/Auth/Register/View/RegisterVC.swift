//
//  RegisterViewController.swift
//  HashTag
//  Created by Mohamed Shendy on 05/02/2023.
//

import UIKit
import LanguageManager_iOS
import UIKit
import FacebookCore
import FBSDKLoginKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import Swifter

class RegisterVC: UIViewController, UIViewControllerTransitioningDelegate{
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var header: LoginHeader!
    @IBOutlet var btnCheck:CheckboxButton!
    @IBOutlet var lblPrivacy:UILabel!
    @IBOutlet var btnPrivacy:UIButton!
    @IBOutlet var btnPassSecure:UIButton!
    
    var userimageURL = ""
    var fromLogin = false
    var fromSheet:Bool?
    var registerVM:RegisterViewModel!
    var loginVM:LoginViewModel?
    var introVM:IntroViewModel?
    var swifter: Swifter!
    var accToken: Credential.OAuthAccessToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGoogleSignin()
        header.delegate = self
        registerVM = RegisterViewModel(twitterDelegate: self, delegate: self, outputDelegate: self)
        introVM = IntroViewModel(delegate: self)
       
        if LanguageManager.shared.isRightToLeft{
            btnPrivacy.contentHorizontalAlignment = .right
        }
    }

    @IBAction func registerTapped(){
        let name = nameTF.text!
        let phone = phoneTF.text!
        let password = passwordTF.text!
        let email = emailTF.text!
        
//MARK: - fields Validations
        if nameTF.text == "" || phoneTF.text == ""  || passwordTF.text == "" || emailTF.text == ""  {
            showErrorAlert(message:Constants.messages.msgFillEmptyFields)
        }else if !isEmailValidCheck(email){
            showErrorAlert(message:Constants.messages.notValidEmail)
        }else if !validatePhoneNumber(phone){
            showErrorAlert(message:Constants.messages.notValidPhone)
        }else if !(password.isValidPassword)  {
            showErrorAlert(message:Constants.messages.notValidpassword)
        } else
        if btnCheck.isChecked == false{
            showErrorAlert(message:Constants.messages.msgCheckPrivacy)
        }else{

//MARK: - Call Register APi
            let uuid = UserData.shared.deviceId ?? ""
            callRegisterApi(name: name, email: email, password: password, phone: phone, uuid: uuid)
        }
    }
    
    func callRegisterApi(name: String,email:String, password: String, phone: String, uuid: String){
        
        if isConnectedToInternet(){
            registerVM?.callRegisterStepOneApi(name: nameTF.text!,email:email, password: password, phone: phone, device: uuid)
        }else{
            registerVM?.delegate?.connectionFailed()
        }
    }
    
     func moveToLoginSheetVC(){
         let vc = LoginSheetVC()
             vc.delegate = self
             vc.fromRegister = true
             vc.modalPresentationStyle = .custom
             vc.transitioningDelegate = self
             self.present(vc, animated: true, completion: nil)
     }
    
    @IBAction func btnCheckAction(){
        if btnCheck.isChecked{
            
        }else{
            
        }
    }
    @IBAction func securePasswordAction(){
        if self.btnPassSecure.image(for: .normal) == UIImage(systemName: "eye.slash.fill") {
            self.btnPassSecure.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            self.passwordTF.isSecureTextEntry = false
        }
        else {
            self.passwordTF.isSecureTextEntry = true
            self.btnPassSecure.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
   @IBAction func openLoginVC() {
        if fromLogin == true {
           self.navigationController?.popViewController(animated: true)
       }else{
           let vc = LoginVC()
           vc.fromRegister = true
           navigationController?.pushViewController(vc, animated: true)
       }
   }
    
    
    
    @IBAction func PrivacyPolicyTapped(){
        registerVM?.outputDelegate?.moveToWebView(type:Constants.appWords.terms,url:General.sharedInstance.privacyLink)
    }
    @IBAction func ClickOnBtnGoogleLogin(_ sender: Any){
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func ClickOnBtnTwitterLogin(_ sender: Any){
        registerVM?.twitterDelegate?.swifterLogin()

    }
    @IBAction func ClickOnBtnFacebook(_ sender: Any){
        facebookLogin()
    }
    @IBAction func appleRegistrationActionButton(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
        handleAuthorizationAppleIDButtonPress()
        }else{
            AlertsManager.showAlert(withTitle: "", message:Constants.messages.internetError, viewController: self,actionHandler:{_ in
                self.navigationController?.popViewController(animated: true)
            } )
        }
    }

    func  setupGoogleSignin(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = #"^(009665|9665|\+9665|05|5)([0-9]{8})$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
    
    func isEmailValidCheck(_ email: String) -> Bool {
        let regExMatchEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicateEmail = NSPredicate(format:"SELF MATCHES %@", regExMatchEmail)
        return predicateEmail.evaluate(with: email)
    }
}

extension RegisterVC:LoginHeaderDelegate,IntroViewModelDelegate{
    func skipToHome() {
        registerVM?.outputDelegate?.moveToHome()
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
    
    func moveToRegister(){
        let vc = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegisterVC:LoginAlertSheetDelegate{
    func dismissAndOpenRegister(fromSheet:Bool) {}
    func reLoadViewController() {}
  
    func dismissAndOpenForgetPassword() {}
}


