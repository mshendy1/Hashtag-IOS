//
//  FacebookLogin.swift
//  HashTag
//
//  Created by Eman Gaber on 09/02/2023.
//

import Foundation
import FacebookCore
import FBSDKLoginKit


extension LoginVC{
    func facebookLogin() {
            let fbLoginManager = LoginManager()
            fbLoginManager.logOut()
            fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                if error != nil { return }
                if let token = AccessToken.current,
                   !token.isExpired {
                    // User is logged in, do work such as go to next view controller.
                    let providerID = AccessToken.current?.userID
                    print(providerID!)
                    self.getFBUserData()
                }
            }
        }

    func getFBUserData(){
           if((AccessToken.current) != nil){
               //,public_profile
               GraphRequest(graphPath: "me", parameters: ["fields": "email,first_name,last_name"]).start { (connection, result, error) -> Void in
                   if (error == nil){

                       guard let info = result as? [String: Any] else { return }
                       let providerID = AccessToken.current?.userID
                       print(providerID!)

                    // Get user profile pic
                    let url = NSURL(string: "http://graph.facebook.com/\(providerID!)/picture?type=large")
                    let urlRequest = NSURLRequest(url: url! as URL)
                    self.userimageURL = "http://graph.facebook.com/\(providerID!)/picture?type=large"
                    General.sharedInstance.userImg = "http://graph.facebook.com/\(providerID!)/picture?type=large"

                       let fb_FirstName = info["first_name"] as? String
                       let fb_LastName = info["last_name"] as? String
                       let email = info["email"] as! String
                       let id = "\(providerID ?? "")"
                       let fbName = "\(fb_FirstName ?? "")"

                       UserDefaults.standard.setUserImage(value: self.userimageURL)
                       UserDefaults.standard.setEmailId(value: email)
                       UserDefaults.standard.setName(value: fbName)

                       General.sharedInstance.socialLoginType = "facebook"
                       self.showSuccessAlertNativeAlert(message: Constants.messages.msgLoginSuccess)
                     
                       if self.isConnectedToInternet() {
                            let token = UserDefaults.standard.getMobileToken()
                           let uuid = UserData.shared.deviceId ?? ""
                           self.logiVM?.callSocialLoginApi(providerName:Constants.appWords.facebook , providerId: id, name: fbName, email: email, firebaseToken: token, deviceId: uuid)
                           }else{
                               self.showNoInternetAlert()
                           }
                      }
                   else{

                    self.showErrorAlert(message: "Sorry please try once again")
                   }
               }

           }

       }
}
