//
//  UIViewController.swift
//  SHAHM
//
//  Created by Mohamed Shendy on 06/01/2023.
//

import Foundation
import CDAlertView
//import PKHUD
import SwiftUI

extension UIViewController {

    static let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    func startLoadingIndicator() {
        let activityIndicator = UIViewController.activityIndicator
        activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .medium
        activityIndicator.color = UIColor.gray
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    func stopLoadingIndicator() {
        let activityIndicator = UIViewController.activityIndicator
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }

    func showErrorAlert(message:String) {
        DispatchQueue.main.async {
            let alert = CDAlertView(title: "", message: message, type: .error)
            alert.autoHideTime = 2.0 // This will hide alert box after 2.0 seconds

            alert.circleFillColor = .systemRed
            alert.messageFont = FontManager.fontWithSize(size: 12,style: .medium)
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .init(rotationAngle: .pi)
                alpha = 0
            }
            alert.hideAnimationDuration = 0.44
            alert.show()
        }
    }
    
    func showErrorNativeAlert(message:String){
        // Create the alert controller
        DispatchQueue.main.async {
            let attributedString = NSAttributedString(string: Constants.messages.error, attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
                NSAttributedString.Key.foregroundColor : UIColor.darkGray
            ])

            let alert = UIAlertController(title:"", message: message, preferredStyle: .alert)
            alert.setValue(attributedString, forKey: "attributedTitle")
            self.present(alert, animated: true, completion: nil)
            // delays execution of code to dismiss
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        }
    }
    func showSuccessAlertNativeAlert(message:String)  {
        // Create the alert controller
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title:"", message: message, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            
            // delays execution of code to dismiss
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        }
    }
   
    func showSuccessAlert(message:String) {
        DispatchQueue.main.async {
            let alert = CDAlertView(title: "", message: message, type: .success)
            alert.autoHideTime = 2.0 // This will hide alert box after 2.0 seconds
            alert.circleFillColor = Colors.PrimaryColor
            alert.messageFont = FontManager.fontWithSize(size: 12,style: .medium)

            alert.hideAnimations = { (center, transform, alpha) in
                transform = .init(rotationAngle: .pi)
                alpha = 0
            }
            alert.hideAnimationDuration = 0.44
            alert.show()
        }
        
        
    }
    
    func showNoInternetAlert() {
        DispatchQueue.main.async {
            let alert = CDAlertView(title: "", message: Constants.messages.no_internet_connection, type: .error)
            alert.autoHideTime = 2.0 // This will hide alert box after 2.0 seconds
            alert.circleFillColor = .systemRed
            alert.messageFont = FontManager.fontWithSize(size: 12,style: .medium)
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .init(rotationAngle: .pi)
                alpha = 0
            }
            alert.hideAnimationDuration = 0.44
            alert.show()
        }
    }
    
    
    
    
    func isConnectedToInternet() -> Bool{
        if Reachability.isConnectedToNetwork(){
            return true
        }else{
            return false
        }
    }
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x,
                                             y: self.center.y,
                                             width: self.bounds.size.width,
                                             height: self.bounds.size.height))
        
        let titleLabel = RegularLabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.font = FontManager.font(withSize: 17)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        let messageLabel = RegularLabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .secondaryLabel
        messageLabel.font = FontManager.font(withSize: 18)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20)
        ])
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}


extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
