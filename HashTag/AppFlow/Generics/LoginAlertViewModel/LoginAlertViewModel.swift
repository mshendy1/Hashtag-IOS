//
//  LoginAlertViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 19/08/1444 AH.
//

import UIKit
import Foundation
protocol LoginAlertViewModelDelegates: AnyObject {
        func LoginActionSuccess()
        func logoutActionSuccess()
        func openAppStore()
        func checkIfUserLoggedIn()
    }

    class LoginAlertViewModel {
        weak var delegate: LoginAlertViewModelDelegates?
        init(delegate:LoginAlertViewModelDelegates) {
            self.delegate = delegate
        }
        func logoutAlert(presenter:UIViewController){
            // Create the alert controller
            let alertController = UIAlertController(title: "", message: Constants.messages.msgLogout, preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "Yes".localiz(), style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.delegate?.logoutActionSuccess()
            }
            let cancelAction = UIAlertAction(title: "No".localiz(), style: UIAlertAction.Style.cancel) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            presenter.present(alertController, animated: true, completion: nil)
            
        }
        
        func loginAlert(presenter:UIViewController){
            // Create the alert controller
            let alertController = UIAlertController(title: "", message: Constants.messages.msgMustLogin.localiz(), preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "Yes".localiz(), style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.delegate?.LoginActionSuccess()
            }
            let cancelAction = UIAlertAction(title: "No".localiz(), style: UIAlertAction.Style.cancel) {
                UIAlertAction in
            }
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            // Present the controller
            presenter.present(alertController, animated: true, completion: nil)
        }

        func sharePost(url:String,presenter:UIViewController,sender:UIButton){
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [url], applicationActivities: nil)
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            // Pre-configuring activity items
            activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook
            ]
            activityViewController.isModalInPresentation = true
            presenter.present(activityViewController, animated: true, completion: nil)
        }

        
        func shareSurvay(titleUrl:String,desUrl:String,presenter:UIViewController,sender:UIButton){
            
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [titleUrl,desUrl], applicationActivities: nil)
            
            // This lines is for the popover you need to show in iPad
            activityViewController.popoverPresentationController?.sourceView = (sender )
            
            // This line remove the arrow of the popover to show in iPad
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            // Pre-configuring activity items
            activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
            
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook
            ]
            
            activityViewController.isModalInPresentation = true
            presenter.present(activityViewController, animated: true, completion: nil)
        }
        
    }


