//
//  GoogleLogin.swift
//  HashTag
//
//  Created by Trend-HuB on 27/10/1444 AH.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

extension LoginSheetVC: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error because\(error.localizedDescription)")
            return
        }
        guard let auth = user.authentication else {return}
        let credentails  = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentails) { autResult, error in
            if let error = error {
                print("Error because\(error.localizedDescription)")
                return
            }
            let providerID =  user.userID!
            let fname = user.profile.givenName!
            let lname = user.profile.familyName!
           var avatar = ""
           if user.profile.hasImage == true {
           avatar = "\(String(describing: user.profile.imageURL(withDimension: 200)!))"
               General.sharedInstance.userImg = avatar
           }
         let userName = user.profile.givenName + " " +  user.profile.familyName
         let email = user.profile.email ?? ""
        let id = "\(providerID )"
    //MARK:- Successfully login with Firebase Hashtage
        
            General.sharedInstance.socialLoginType = Constants.appWords.google
            UserDefaults.standard.setUserImage(value: avatar )
            UserDefaults.standard.setEmailId(value: email)
            UserDefaults.standard.setName(value: userName)

            if self.isConnectedToInternet() {
                 let token = UserDefaults.standard.getMobileToken()
                let uuid = UserData.shared.deviceId ?? ""
                self.logiVM?.callSocialLoginApi(providerName:Constants.appWords.google, providerId: id, name: userName, email: email, firebaseToken: token, deviceId: uuid)
                }else{
                    self.showNoInternetAlert()
                }
        }
    }
}
