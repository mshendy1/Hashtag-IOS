//
//  ResetPasswordVC.swift
//  HashTag
//
//  Created by Mohamed Shendy on 06/02/2023.
//

import UIKit
protocol ResetPasswordDelegate {
    func openLogin()
    func openLoginSheet()
    func dismissResetPassword()
}

class ResetPasswordVC: UIViewController {
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet var btnPassSecure:UIButton!
    @IBOutlet var btnConfirmPassSecure:UIButton!

    
    var delegate:ResetPasswordDelegate?
    var forgetPasswordVM:ForgetPasswordViewModel?
    var phoneOrEmailText:String?
    var isEmail:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        forgetPasswordVM = ForgetPasswordViewModel(delegate:self)
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
    @IBAction func dismissPopup(){
        delegate?.dismissResetPassword()
    }
    
    @IBAction func secureConfirmPasswordAction(){
        if self.btnConfirmPassSecure.image(for: .normal) == UIImage(systemName: "eye.slash.fill") {
            self.btnConfirmPassSecure.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            self.confirmPasswordTF.isSecureTextEntry = false
        }
        else {
            self.confirmPasswordTF.isSecureTextEntry = true
            self.btnConfirmPassSecure.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    @IBAction func cotinue(_ sender:UIButton){
        if passwordTF.text == "" || confirmPasswordTF.text  == ""
        {
            showErrorAlert(message:Constants.messages.msgFillEmptyFields)
        }else if  passwordTF.text != confirmPasswordTF.text! {
            showErrorAlert(message: Constants.messages.msgPasswordsNotMatched)
        }else{
            callResetPasswordAPI()
        }
    }
    
    func callResetPasswordAPI(){
        if isConnectedToInternet(){
            if isEmail == true{
                forgetPasswordVM?.callUpdatePasswordApi(password: passwordTF.text!, email: phoneOrEmailText ?? "", phone: "", passwordConfirmation: confirmPasswordTF.text!)
            }else{
                forgetPasswordVM?.callUpdatePasswordApi(password: passwordTF.text!, email: "", phone: phoneOrEmailText!, passwordConfirmation: confirmPasswordTF.text!)
            }
        }else{
            forgetPasswordVM?.delegate?.connectionFailed()
        }

    }

}


