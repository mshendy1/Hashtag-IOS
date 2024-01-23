//
//  ForgetPasswordVC.swift
//  HashTag
//
//  Created by Mohamed Shendy on 05/02/2023.
//

import UIKit

protocol ForgetPasswordDelegate {
    func didEnterdPhoneOrEmailText(textApi:String,isEmail:Bool)
}

class ForgetPasswordVC:BaseBottomSheetViewController {
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbldesc: UILabel!
    @IBOutlet weak var btnEmail: UIButton!

    var delegate: ForgetPasswordDelegate?
    var phone:String?
    var forgetPasswordVM:ForgetPasswordViewModel?
    var checkIsEmail:Bool?
    let myAttributes: [NSAttributedString.Key: Any] = [
        .font:FontManager.font(withSize: 15),
        .foregroundColor: Colors.PrimaryColor,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ] // .double.rawValue, .thick.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIsEmail = false
        forgetPasswordVM = ForgetPasswordViewModel(delegate: self)
       
        let attributeString = NSMutableAttributedString(
            string: "email".localiz(),
           attributes: myAttributes)
        btnEmail.setAttributedTitle(attributeString, for: .normal)
       
        if phone != nil{
            userTF.text = phone
        }
    }
    
    @IBAction func dismissPopup(){
        self.dismiss(animated: true)
    }
    
    @IBAction func btnCheckIsEmail(){
        if checkIsEmail == false{
            checkIsEmail = true
            lbldesc.text = Constants.appWords.enterEmailToResetPass
            userTF.placeholder = Constants.appWords.email
            userTF.keyboardType = .emailAddress
            let attributeString = NSMutableAttributedString(
                string: Constants.appWords.phone,
               attributes: myAttributes
            )
            btnEmail.setAttributedTitle(attributeString, for: .normal)
        }else{
            lbldesc.text = Constants.appWords.enterPhoneToResetPass
            userTF.keyboardType = .numberPad
            userTF.placeholder = Constants.appWords.phone
            let attributeString = NSMutableAttributedString(
                string: Constants.appWords.email,
               attributes: myAttributes
            )
            btnEmail.setAttributedTitle(attributeString, for: .normal)
            checkIsEmail = false
        }
    }
    
    @IBAction func continueAction(_ sender: Any) {
        if userTF!.text == "" {
            showErrorAlert(message: Constants.appWords.enterPhoneMsg)
        }else {
            if isConnectedToInternet(){
                if checkIsEmail == false{
                    forgetPasswordVM?.callSendCodeApi(phone: userTF!.text!, email: "")
                }else{
                    forgetPasswordVM?.callSendCodeApi(phone:"", email: userTF!.text!)
                }
                
            }else{
                forgetPasswordVM?.delegate?.connectionFailed()
            }
        }
    }


    
    
}
