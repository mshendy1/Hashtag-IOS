//
//  AppleLogin.swift
//  HashTag
//
//  Created by Mohamed Shendy on 22/12/2022.
//

import Foundation
import AuthenticationServices


import Foundation
import AuthenticationServices

extension  LoginVC : ASAuthorizationControllerDelegate{
    /// - Tag: add_appleid_button
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        authorizationButton.setHeight(50)
        authorizationButton.clipsToBounds = true
    }
    // - Tag: perform_appleid_password_request
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    /// - Tag: perform_appleid_request
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
            let email = appleIDCredential.email
            
            General.sharedInstance.socialLoginType = Constants.appWords.apple
             let token = UserDefaults.standard.getMobileToken()
            let uuid = UserData.shared.deviceId ?? ""
           
            if email != nil {
                self.saveUserInKeychain(userIdentifier,email: email ?? "" ,name: fullName)
            }
            if self.isConnectedToInternet() {
                    let name = KeychainItem.currentUserName
                    let email = KeychainItem.currentUserEmail
                    self.logiVM?.callSocialLoginApi(providerName:Constants.appWords.apple, providerId: userIdentifier, name: name, email: email, firebaseToken: token, deviceId: uuid)
                
                
            }else{
                self.showNoInternetAlert()
            }
        default:
            break
        }
    }
    
    private func  saveUserInKeychain(_ userIdentifier: String,email:String, name:String) {
        do {
            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
        
        do {
            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userEmail").saveItem(email)
        } catch {
            print("Unable to save userEmail to keychain.")
        }
        do {
            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userName").saveItem(name)
        } catch {
            print("Unable to save userName to keychain.")
        }
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}



