//
//  EventsDetailsVC.swift
//  HashTag
//
//  Created by Trend-HuB on 02/08/1444 AH.
//

import UIKit
import MapKit

class EventsDetailsVC: UIViewController {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var lblLocation:UILabel!
    @IBOutlet weak var lblMonth:UILabel!
    @IBOutlet weak var lblDay:UILabel!
    @IBOutlet weak var imgEvent:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDesc:UILabel!
    @IBOutlet weak var lblTime:UILabel!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var imgMark:UIImageView!
    @IBOutlet weak var viewMark:UIView!
    @IBOutlet weak var viewFaceBook:UIView!
    @IBOutlet weak var viewinsta:UIView!
    @IBOutlet weak var viewBrowser:UIView!
    @IBOutlet weak var btnPlay:UIButton!
   
    let uuid = UserData.shared.deviceId ?? ""
    var loginAlertVM:LoginAlertViewModel?
    var eventDetailsVM:EventDetailsViewModel!
    var eventId:Int!
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isHidden = true
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.postDetailsTitle
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        eventDetailsVM = EventDetailsViewModel(delegate: self)
        loginAlertVM = LoginAlertViewModel(delegate: self)
        callGetEventDetailsApi()
    }
    
    func moveToLoginSheetVC(){
        let vc = LoginSheetVC()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    func callGetEventDetailsApi(){
        if isConnectedToInternet(){
            if !UserDefaults.standard.isLoggedIn(){
                eventDetailsVM.callGetEventDetailsApi(evetId: eventId, deviceId: self.uuid)
            }else{
                eventDetailsVM.callGetEventDetailsApi(evetId: eventId, deviceId: "")
            }
        }else{
            eventDetailsVM.delegate?.connectionFailed()
        }
    }
    
    @IBAction func addtoFav(_ sender:UIButton){
            if isConnectedToInternet(){
                if !UserDefaults.standard.isLoggedIn(){
                    let uuid = UserData.shared.deviceId ?? ""
                    eventDetailsVM.addEventToFavApi(id: eventId,deviceId: uuid)
                }else{
                    eventDetailsVM.addEventToFavApi(id: eventId,deviceId: "")
                }
            }else{
                eventDetailsVM.delegate?.connectionFailed()
            }
    }
    
    @IBAction func facebookAction(_ sender:UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            moveToLoginSheetVC()
        }else{
            
            if let link = URL(string:eventDetailsVM.eventDetails?.twitter ?? "") {
                UIApplication.shared.open(link)
            }
        }
    }
    
    @IBAction func websiteAction(_ sender:UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            moveToLoginSheetVC()
        }else{
            if let link = URL(string:eventDetailsVM.eventDetails?.website ?? "") {
                UIApplication.shared.open(link)
            }
        }
        }
    
    @IBAction func instagramAction(_ sender:UIButton){
        if !UserDefaults.standard.isLoggedIn(){
            moveToLoginSheetVC()
        }else{
            if let link = URL(string:eventDetailsVM.eventDetails?.instagram ?? "") {
                UIApplication.shared.open(link)
            }
        }
    }
    
    @IBAction func sopenMapAction(_ sender:UIButton){
        let vc = SelectAddressVC()
        vc.selected_latitude = eventDetailsVM?.eventDetails?.lat ?? 0.0
        vc.selected_longitude = eventDetailsVM?.eventDetails?.lng ?? 0.0
        self.navigationController?.pushViewController(vc, animated: true)
    }


    @IBAction func shareEventAction(_ sender:UIButton){
            let url = eventDetailsVM.eventDetails?.url ?? ""
            loginAlertVM?.sharePost(url: url, presenter: self, sender: sender)
    }
    
    @IBAction func playVideo(_ sender:UIButton) {
        let vc =  WebViewVC()
       vc.twitter = false
       vc.url = eventDetailsVM.eventDetails?.video
       self.navigationController?.pushViewController(vc, animated: true)
   }
    
}

extension EventsDetailsVC:AuthNavigationDelegate{
    func turAction() {
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension EventsDetailsVC:LoginAlertSheetDelegate{
    func dismissAndOpenRegister(fromSheet: Bool) {
        self.dismiss(animated: true){
                let vc = RegisterVC()
                vc.fromSheet = fromSheet
                self.navigationController?.pushViewController(vc, animated: true)
        }
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
    
    func reLoadViewController() {
        callGetEventDetailsApi()
    }
}

extension EventsDetailsVC:ForgetPasswordDelegate{
    func didEnterdPhoneOrEmailText(textApi: String, isEmail: Bool) {
        moveToConfirmOTPVC(emailOrPhoneText: textApi, isEmail: isEmail)
    }
    func dismissAndOpenResetVC(phone: String) {
        moveToResetPasswordVC(phoneOrEmail: phone, isEmail:false)
    }
}

extension EventsDetailsVC:VerificationCodeDelegate{
    func dismissAndOpenResetVC(phoneOrEmail: String, isEmail: Bool) {
        moveToResetPasswordVC(phoneOrEmail: phoneOrEmail,isEmail:isEmail)
    }
    
    func backAndOpenForgetVC(phoneOrEmail: String, isEmail: Bool) {
        self.openForgetPassword(phoneOrEmail:phoneOrEmail,animated:false)
    }

}
extension EventsDetailsVC:ResetPasswordDelegate{
    func openLoginSheet() {
        self.dismiss(animated: true){
            self.moveToLoginSheetVC()
        }
    }
    
    func openLogin() {}
    
    func dismissResetPassword() {
        self.dismiss(animated: true)
    }
}
