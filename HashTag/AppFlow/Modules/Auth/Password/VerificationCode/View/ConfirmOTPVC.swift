//
//  VerificationCodeViewController.swift
//  HashTag
//
//  Created by Mohamed Shendy on 06/02/2023.
//

import UIKit
import AEOTPTextField

protocol VerificationCodeDelegate {
    func backAndOpenForgetVC(phoneOrEmail: String,isEmail:Bool)
    func dismissAndOpenResetVC(phoneOrEmail: String,isEmail:Bool)
}

class ConfirmOTPVC: BaseBottomSheetViewController,OTPDelegate {
    func didChangeValidity(isValid: Bool) {
        //true
    }
    var phoneOrEmail:String?
    var isEmail:Bool?
    let otpStackView = OTPStackView()
    var delegate:VerificationCodeDelegate?
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var forgetPasswordVM:ForgetPasswordViewModel?
    @IBOutlet weak var otpContainerView: UIView!
    @IBOutlet weak var lblResend:UILabel!
    @IBOutlet weak var lblCountDown:UILabel!
    @IBOutlet weak var btnResend:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        forgetPasswordVM = ForgetPasswordViewModel(delegate: self)
        setupOTPStack()
        addAttributeString()
        runTimer()
    }
    
    func addAttributeString(){
        let attributedString = NSMutableAttributedString.init(string: "resend code".localiz())
        // Add Underline Style Attribute.
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        lblResend.attributedText = attributedString
    }
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds > 0{
            seconds -= 1
            lblCountDown.text = "\(seconds)"
            btnResend.isUserInteractionEnabled = false
            lblResend.textColor = UIColor.init(named: "#74788D80")
        }else{
            btnResend.isUserInteractionEnabled = true
            lblResend.textColor = UIColor.init(hex:"#059E4B")

            timer.invalidate()
        }
    }
    
     func setupOTPStack(){
        otpContainerView.addSubview(otpStackView)
        otpStackView.delegate = self
        otpStackView.heightAnchor.constraint(equalTo: otpContainerView.heightAnchor).isActive = true
        otpStackView.centerXAnchor.constraint(equalTo: otpContainerView.centerXAnchor).isActive = true
        otpStackView.centerYAnchor.constraint(equalTo: otpContainerView.centerYAnchor).isActive = true
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        forgetPasswordVM?.callSendCodeApi(phone: phoneOrEmail!, email: "")
    }
    
    
    @IBAction func conntinueTapped(_ sender: UIButton) {
        if otpStackView.getOTP() == "" {
            showErrorAlert(message: "Enter phone first".localiz())
        }else {
            if isConnectedToInternet(){
                if isEmail == true{
                    forgetPasswordVM?.callCheckCodeApi(code: otpStackView.getOTP(), phone: "", email:phoneOrEmail ?? "")
                }else{
                    forgetPasswordVM?.callCheckCodeApi(code: otpStackView.getOTP(), phone: phoneOrEmail ?? "", email: "")
                }
            }else{
                forgetPasswordVM?.delegate?.connectionFailed()
            }
        }
    }

    
    
    
    @IBAction func backAction(){
        self.dismiss(animated: true){
            self.delegate?.backAndOpenForgetVC(phoneOrEmail:self.phoneOrEmail ?? "", isEmail:self.isEmail ?? false)
        }
    }

    
}




