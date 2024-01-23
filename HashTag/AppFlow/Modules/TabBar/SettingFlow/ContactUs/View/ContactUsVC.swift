//
//  ContactUsVC.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import UIKit
import MessageUI
class ContactUsVC: UIViewController,UITextViewDelegate {
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var collection:UICollectionView!
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tvDesc:UITextView!
    @IBOutlet weak var placeHolderLbl:UILabel!
    @IBOutlet weak var emailLbl:UILabel!
    @IBOutlet weak var phoneLbl:UILabel!
    @IBOutlet weak var phoneImg:UIImageView!
    @IBOutlet weak var emailImg:UIImageView!

//var socilaArr = []
    var ContactUsVM:ContactUsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tvDesc.delegate = self
        navigationController?.isNavigationBarHidden = true
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.contactUsTitle
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        ContactUsVM = ContactUsViewModel(delegate: self)
        callGetContactUsApi()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.placeHolderLbl.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tvDesc.text.isEmpty {
            self.placeHolderLbl.isHidden = false
        } else {
            self.placeHolderLbl.isHidden = true
        }
    }
    
    @IBAction func callUsRequest(_sender :UIButton){
        let phone = ContactUsVM?.contactUsObjc?.phone ?? ""
        ContactUsVM?.delegate?.callUSTApped(phone: phone)
    }
    @IBAction func openMailTapped(_sender :UIButton){
        let email = ContactUsVM?.contactUsObjc?.email ?? ""
        ContactUsVM?.delegate?.sendMailToTapped(email: email)
    }
    

    @IBAction func sendRequest(_sender :UIButton){
        if tfEmail.text == "" || tvDesc.text == ""{
            showErrorAlert(message: Constants.messages.msgFillEmptyFields)
        }else{
            callSendRequestApi(email: tfEmail.text!, device: "ios", desc: tvDesc.text!)
        }
    }
    
    func callSendRequestApi(email:String,device:String,desc:String){
        if isConnectedToInternet(){
            ContactUsVM?.sendRequestAPI(email: email, device: device, desc: desc)
        }else{
            showNoInternetAlert()
        }
    }
    func callGetContactUsApi(){
        if isConnectedToInternet(){
            ContactUsVM?.getContactUsAPI()
        }else{
            showNoInternetAlert()
        }

    }



}
extension ContactUsVC:AuthNavigationDelegate{
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func turAction() {
        
    }
    
    
}
