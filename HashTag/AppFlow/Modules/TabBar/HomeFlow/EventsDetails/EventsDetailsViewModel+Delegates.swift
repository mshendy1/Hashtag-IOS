//
//  EventDetailsViewModel+Delegates.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.
//

import Foundation

import Foundation
import CoreLocation
import MapKit
import UIKit

extension EventsDetailsVC:EventDetailsViewModelDelegates,AddToFavouritesViewModelDelegates,LoginAlertViewModelDelegates,UIViewControllerTransitioningDelegate{
    func openAppStore() {}
    
    func checkIfUserLoggedIn() {}
    
    func LoginActionSuccess() {
        eventDetailsVM?.delegate?.moveToLogin()
    }
    func logoutActionSuccess() { }
    func moveToLogin(){
        let vc = LoginVC()
        General.sharedInstance.mainNav!.pushViewController(vc, animated: true)
    }
    func addToFavSuccessfully(id: Int, type: Types) {
        eventDetailsVM?.callGetEventDetailsApi(evetId: eventId, deviceId: self.uuid)
    }
   
    func addToFavSuccessfully() {
                let bookmark = !(eventDetailsVM?.eventDetails!.bookmark)!
        eventDetailsVM.eventDetails?.bookmark = bookmark
       setBookMark()
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
        showErrorNativeAlert(message: error)
    }


    func getEventDetailsSuccessfully(model:EventDetailsModel?){
        
        if model?.video == "" {
            btnPlay.isHidden = true
        }else{
            btnPlay.isHidden = false
        }
        
        if model?.twitter == "" {
            viewFaceBook.isHidden = true
        }else if model?.instagram == ""
        {
        viewinsta.isHidden = true
        }else if model?.website == "" {
            viewBrowser.isHidden = true
        }
        
        lblLocation.text = model?.location ?? ""
        lblMonth.text = model?.createdAtMonth ?? ""
        lblDay.text = model?.createAtDayNumber ?? ""
        imgEvent.loadImage(path: model?.mainPhoto ?? "")
        lblTitle.text = (model?.title ?? "").htmlToString
        lblDesc.text = (model?.description ?? "").htmlToString
        //let timeText = model?.timeAmOrPm ?? ""
        lblTime.text = "\(model?.createdTime ?? "") \(model?.timeAmOrPm ?? "")"
        setBookMark()
        
        let lat = model?.lat ?? 0.0
        let long = model?.lng ?? 0.0
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = CLLocationCoordinate2D(latitude:lat , longitude: long)
        annotaion.title  = model?.location ?? ""
        
        mapView.addAnnotation(annotaion)
        let region = MKCoordinateRegion(center: annotaion.coordinate, latitudinalMeters: 8000, longitudinalMeters: 8000)
        mapView.setRegion(region, animated: true)
        scrollView.isHidden = false
    }
    
    func setBookMark(){
        let fav = eventDetailsVM.eventDetails?.bookmark
        if fav == true {
            imgMark.image = UIImage.init(named: "FAV")
            viewMark.backgroundColor = Colors.PrimaryColor
        }else{
           imgMark.image = UIImage.init(named: "FAV")
           viewMark.backgroundColor =  .secondaryLabel
        }
    }
    
    func setLocationOnMap(lat:Double,long:Double){
        let restaurantLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        //Center the map on the place location
        mapView.setCenter(restaurantLocation, animated: true)

    }
    
    func moveToConfirmOTPVC(emailOrPhoneText:String,isEmail:Bool){
        let vc = ConfirmOTPVC()
        vc.delegate = self
        vc.phoneOrEmail = emailOrPhoneText
        vc.isEmail = isEmail
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func moveToResetPasswordVC(phoneOrEmail: String,isEmail:Bool){
        let vc = ResetPasswordVC()
        self.type = Constants.appWords.resetPAss
        vc.delegate = self
        vc.phoneOrEmailText = phoneOrEmail
        vc.isEmail = isEmail
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    func openForgetPassword(phoneOrEmail:String?,animated:Bool) {
        if let vc = ForgetPasswordVC.instantiateFromAppStoryboard(.forgetPassword){
            vc.phone = phoneOrEmail
            vc.delegate = self
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = self
            self.present(vc, animated: animated, completion: nil)
        }
    }

}
