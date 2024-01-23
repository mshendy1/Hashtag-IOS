//
//  UserDefaults.swift
//  BasetaApp
//
//  Created by Eman Gaber on 20/05/2022.
//

import Foundation

import Foundation
import SwiftyJSON

extension UserDefaults
{
    func setLogout(){
        removeObject(forKey:UserDefaultsKeys.isLoggedIn.rawValue)
        removeObject(forKey: UserDefaultsKeys.name.rawValue)
        removeObject(forKey: UserDefaultsKeys.emailId.rawValue)
        UserData.userLoggedOut()
    }
    
    func setBranch(value: JSON){
        set(value.rawString(), forKey: UserDefaultsKeys.branch.rawValue)
    }

    func getBranch() -> JSON? {
        guard let result = string(forKey: UserDefaultsKeys.branch.rawValue) else {
            return nil
        }
        
        if result != "" {
            if let json = result.data(using: String.Encoding.utf8, allowLossyConversion: false){
                do {
                    return try JSON(data: json)
                }
                catch {
                    return nil
                }
            }
            else {
                return nil
            }
        } else {
            return nil
        }
    }

    
    func clearUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        self.removePersistentDomain(forName: domain)
        self.synchronize()
    }
    
    func setVoipToken(value: String){
        set(value, forKey: UserDefaultsKeys.voipToken.rawValue)
    }
    
    func getVoipToken() -> String {
        guard string(forKey: UserDefaultsKeys.voipToken.rawValue) != nil  else  {
            return ""
        }
        return string(forKey: UserDefaultsKeys.voipToken.rawValue)!
    }
    
    func setProfilePic(value: String) {
        set(value, forKey: UserDefaultsKeys.profilePic.rawValue)
    }
    
    func getProfilePic() -> String {
        guard string(forKey: UserDefaultsKeys.profilePic.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.profilePic.rawValue)!
    }

    
    func setCountryCode(value: String) {
        set(value, forKey: UserDefaultsKeys.countryCode.rawValue)
    }
    
    func getCountryCode() -> String {
        guard string(forKey: UserDefaultsKeys.countryCode.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.countryCode.rawValue)!
    }
    
    func setLatitude(value: String){
        set(value, forKey: UserDefaultsKeys.latitude.rawValue)
    }
    
    func getLatitude() -> String
    {
        guard string(forKey: UserDefaultsKeys.latitude.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.latitude.rawValue)!
    }

    
    func setLongitude(value: String)
    {
        set(value, forKey: UserDefaultsKeys.longitude.rawValue)
    }
    
    func getLongitude() -> String
    {
        guard string(forKey: UserDefaultsKeys.longitude.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.longitude.rawValue)!
    }

    func setUserId(value: String)
    {
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
    }
    
    func getUserId() -> String
    {
        guard string(forKey: UserDefaultsKeys.userID.rawValue) != nil  else
        {
            return "0"
        }
        return string(forKey: UserDefaultsKeys.userID.rawValue)!
    }

    func setName(value: String)
    {
        set(value, forKey: UserDefaultsKeys.name.rawValue)
    }
    
    func getName() -> String {
        guard string(forKey: UserDefaultsKeys.name.rawValue) != nil  else {return ""}
        return string(forKey: UserDefaultsKeys.name.rawValue)!
    }
    
    func setLoggedIn(value: Bool){
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    func setGuest(value: Bool){
        set(value, forKey: UserDefaultsKeys.isGuest.rawValue)
    }
    func setNotifiaction(value: Bool){
        set(value, forKey: UserDefaultsKeys.isNotification.rawValue)
    }
   
    func getIsNotifiaction() -> Bool{
        guard string(forKey: UserDefaultsKeys.isNotification.rawValue) != nil  else {
            return false
        }
        return bool(forKey: UserDefaultsKeys.isNotification.rawValue)
        
    }
    func isNotification()-> Bool {
        return bool(forKey: UserDefaultsKeys.isNotification.rawValue)
    }
    
    func isLoggedIn()-> Bool{
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func isGuest()->Bool{
        return bool(forKey: UserDefaultsKeys.isGuest.rawValue)
    }
    
    func setEmailId(value: String){
        set(value, forKey: UserDefaultsKeys.emailId.rawValue)
    }
    
    func getEmailId() -> String {
        guard string(forKey: UserDefaultsKeys.emailId.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.emailId.rawValue)!
    }
    
    func setFirstName(value: String) {
        set(value, forKey: UserDefaultsKeys.firstName.rawValue)
    }
    
    func setUserAddress(value: String){
        set(value, forKey: UserDefaultsKeys.userAddress.rawValue)
    }
    
    func getUserAddress() -> String{
        guard string(forKey: UserDefaultsKeys.userAddress.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.userAddress.rawValue)!
    }

    func getFirstName() -> String{
        guard string(forKey: UserDefaultsKeys.firstName.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.firstName.rawValue)!
        
    }
    
    func setLastName(value: String){
        set(value, forKey: UserDefaultsKeys.lastName.rawValue)
    }
    
    func getLastName() -> String{
        guard string(forKey: UserDefaultsKeys.lastName.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.lastName.rawValue)!
    }
    
    func setMobileNo(value: String) {
        set(value, forKey: UserDefaultsKeys.mobileNo.rawValue)
    }
    
    func getMobileNo() -> String {
        guard string(forKey: UserDefaultsKeys.mobileNo.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.mobileNo.rawValue)!
        
    }
    
    func setMobileToken(value: String)
    {
        set(value, forKey: UserDefaultsKeys.mobileToken.rawValue)
    }
    
    func getMobileToken() -> String
    {
        guard string(forKey: UserDefaultsKeys.mobileToken.rawValue) != nil  else
        {
            return ""
        }
        return string(forKey: UserDefaultsKeys.mobileToken.rawValue)!
    }
    
    func setAccessToken(value: String)
    {
        set(value, forKey: UserDefaultsKeys.accessToken.rawValue)
    }
    
    func getAccessToken() -> String
    {
        guard let accessToken = string(forKey: UserDefaultsKeys.accessToken.rawValue)
            else
        {
            return ""
        }
        return accessToken
    }
    
   
    func setUserImage(value: String)
    {
        set(value, forKey: UserDefaultsKeys.userImage.rawValue)
    }
    
    func getUserImage() -> String
    {
        guard let accessToken = string(forKey: UserDefaultsKeys.userImage.rawValue)
            else
        {
            return ""
        }
        return accessToken
    }
    
    func setRating(value: Double)
    {
        set(value, forKey: UserDefaultsKeys.rating.rawValue)
    }
    
    func getRating() -> Double
    {
        return double(forKey: UserDefaultsKeys.rating.rawValue)
    }
    
    func setUserInfo(value: [AnyHashable: Any])
    {
        set(value, forKey: UserDefaultsKeys.userInfo.rawValue)
    }
    
    func getUserInfo() -> [AnyHashable: Any]
    {
        return dictionary(forKey: UserDefaultsKeys.userInfo.rawValue) ?? [:]
    }
    
    
    
    func getLanguage() -> String? {
        
        guard let language = string(forKey: UserDefaultsKeys.language.rawValue)
            else
        {
            return ""
        }
        return language
    }
}


enum UserDefaultsKeys : String {
    case isLoggedIn
    case isGuest
    case isSocialLoggedIn
    case firstName
    case lastName
    case mobileNo
    case accessToken
    case userImage
    case rating
    case emailId
    case language
    case name
    case userID
    case latitude
    case longitude
    case countryCode
    case profilePic
    case voipToken
    case mobileToken
    case branch
    case userAddress
    case isNotification
    case userInfo
}
