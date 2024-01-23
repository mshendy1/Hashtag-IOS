//
//  AppConstants.swift
//  BasetaApp
//
//  Created by Mohamed Shendy on 4/9/22.
//

import Foundation
import UIKit
import LanguageManager_iOS
//import MIAlertController
//
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let mainColor = #colorLiteral(red: 0.3207446337, green: 0.6371595263, blue: 0.8308730125, alpha: 1)
let greyColor = #colorLiteral(red: 0.961928308, green: 0.9620661139, blue: 0.9618980289, alpha: 1)
let brownColor = #colorLiteral(red: 0.961928308, green: 0.9620661139, blue: 0.9618980289, alpha: 1)
let shadowColor = #colorLiteral(red: 0.961928308, green: 0.9620661139, blue: 0.9618980289, alpha: 1)


import UIKit


struct Constants {
    static let isArabic = false
    static let messages = Messages()
    static let titles = Titles()
    static let home = HomeLocz()
    static let PagesTitles = HeadersTitles()
    static let homeType = selectedType()
    static let buttons = ButtonsTitles()
    static let appWords = Words()
    static let TwitterConstants = twitterKeys()
    static let defaultsImages = images()
    static let googlsMapKeys = googlsMapsKeys()
}


struct images{
    var defaultPostImg:String{return ""}
}

struct Titles {
    var done: String {return "ok" }
    var yes: String {return "yes" }
    var no: String {return "no" }
    var forgotPass:String{return "Forgot Password?"}
    var skip:String {return "Skip"}
    var policy:String{return "policy and privacy"}
    var addNewEvent:String{return "add_new_events".localiz()}
}
struct Messages {
    var updatPasswordMsg:String{return"Password updated successfully".localiz()}
    var registerSuccessfullyMsg:String{return"Register Successfully".localiz()}
    var sendcontactUsMsg: String {return "send_contactUs_request_done".localiz() }
    var connectionFailed: String {return "فشل في الإتصال" }
    var no_internet_connection: String {return "لا  يوجد إتصال باالإنترنت" }
    var fillEmptyFields: String {return "من فضل أدخل بياناتك"}
    var emptysearchText:String{return "enter_Search_Keyword".localiz()}
    var emptyMyCompletedEvente:String{return"ليس لديك أحداث مكتملة"}
    var emptyMyRecentEvente:String{return"ليس لديك أحداث "}
    var emptysearchTable:String{return"لا توجد نتائج للبحث"}
    var LoginSuccMsg:String{return"Login Successfully".localiz()}
    var notValidPhone:String{return"Please enter valid Saudi Arabia mobile".localiz()}
    var notValidpassword:String{return"password length must be 6 numbers or more".localiz()}
    var notValidEmail:String{return"Please enter valid email".localiz()}
    var emptyAddress:String{return"Plz_select_address".localiz()}
    var errorLocate:String{return"Error_locating_location".localiz()}
    var error:String{return"Error".localiz()}
    var currentLocation:String{return"My current location".localiz()}
    var plzSelectCats:String{return"Please select categories".localiz()}
    var plzselectTags:String{return"Please select tags".localiz()}
    var internetError:String{return "Internet_connection_error".localiz()}
    var catAddedSucc:String{return"Categories added successfully".localiz()}
    var tagsAddedSucc:String{return"Tags added successfully".localiz()}
    var msgEmptyPostsList:String{return"No Posts Found".localiz()}
    var msgEmptyEventsList:String{return"No Events Found".localiz()}
    var msgEmptyPollsList:String{return"NoـPollsـFound".localiz()}
    var msgMustLogin:String{return"you must login first".localiz()}
    var msgEmptyFavPolls:String{return"No Fav Polls Found".localiz()}
    var msgEmptyFavPosts:String{return"No Fav Posts Found".localiz()}
    var msgEmptyFavEvents:String{return"No Fav Events Found".localiz()}
    var msgLoginSuccess:String{return"Login_success".localiz()}
    var msgLogout:String{return"you want to logout".localiz()}
    var msgDeleteAccount:String{return"you want to delete account".localiz()}
    var msgLoginFaild:String{return"Login Failed".localiz()}
    var msgGuestFaild:String{return"guest login Failed".localiz()}
    var msgnoDataFound:String{return"no_data_try_again_later".localiz()}
    var msgNoNotificationsFound:String{return"no_Notifications_found".localiz()}
    var msgCheckPrivacy:String{return"check_privacy".localiz()}
    var msgFillEmptyFields:String{return"Please_fill_all_fields".localiz()}
    var msgPasswordsNotMatched:String{return"Passwords not matched".localiz()}
    var forceUpdateMsg:String{return"A new version of HashTag is available on. Update now!".localiz()}
    var Update:String{return"Update".localiz()}
    var NotNow:String{return"NotNow".localiz()}
    var msgSelectCategory:String{return"Please select categories".localiz()}
    var emptyEvents:String{return "No_Events_in_your_account".localiz()}
    

}


struct twitterKeys{
    var consumerKey = "3YgCnJG3HzSwzmFgmQa8snsIz"
    var consumerSecret = "4cd7BqPFD80BZc2qOhSq4cxwBLcquxwUl3YQ7eTbrrVWe0Atg4"
    var callbackUrl = "twitter-3YgCnJG3HzSwzmFgmQa8snsIz://"
}
struct googlsMapsKeys{
    var provideAPIKey = "AIzaSyD5onmfjofDOCSLAszkgGv7o7haIlseHtw"
}

struct ButtonsTitles{
    var btnViewServey = "View the survey".localiz()
    var btnDateofBirth = "date of birth".localiz()
    var btnChangePassword = "Change the secret code?".localiz()
    var btnSlelctGender = "select date of birth".localiz()
    var btnEdit = "Edit".localiz()
}



struct HomeLocz {
    var news = "news".localiz()
    var trend = "trend".localiz()
    var surveys = "surveys".localiz()
    var events = "events".localiz()
}

struct HeadersTitles {
    var postDetailsTitle = "Details".localiz()
    var favTitle = "Favourites".localiz()
    var searchTitle = "Search".localiz()
    var myEventsTitle = "My Events".localiz()
    var notificationsTitle = "Notifications".localiz()
    var settingsTitle = "Settings".localiz()
    var profileTitle = "Profile".localiz()
    var commonQuesTitle = "commonQues".localiz()
    var contactUsTitle = "contactUs".localiz()
    var privacyTitle = "Privacy".localiz()
    var termsTitle = "Terms".localiz()
    var addressTitle = "AddressLocation".localiz()
    var selectCatTitle = "select_categ".localiz()
    var postsTitle = "posts".localiz()

}

struct selectedType{
    var news = "news"
    var trend = "trend"
    var surveys = "surveys"
    var events = "events"

}


struct Words{
    var email = "email".localiz()
    var phone = "phone".localiz()
    var enterPhoneMsg = "Enter_phone_first".localiz()
    var enterEmailToResetPass = "Enter your email to be sent a reset code".localiz()
    var enterPhoneToResetPass = "Enter your phone to be sent a reset code".localiz()
    var selectDateOfBirth = "select_date_of_birth".localiz()
    var selectGender = "select_gender".localiz()
    var resetPAss = "ResetPassword".localiz()
    var searches = "Searches".localiz()
    var tweets = "tweets".localiz()
    var viwes = "views".localiz()
    var terms = "terms".localiz()
    var news = "news".localiz()
    var yes = "Yes".localiz()
    var no = "No".localiz()
    var google = "google"
    var apple = "apple"
    var twitter = "twitter"
    var facebook = "facebook"
    var mobileToken = "mobileToken"
}




//MARK: - Constants
struct ConstantsUploadFile {
    static let actionFileTypeHeading = "Add a File"
    static let actionFileTypeDescription = "Choose a filetype to add..."
    static let camera = "Camera"
    static let phoneLibrary = "Phone Library"
    static let video = "Video"
    static let file = "File"
    
    static let alertForPhotoLibraryMessage = "App does not have access to your photos. To enable access, tap settings and turn on Photo Library Access."
    static let alertForCameraAccessMessage = "App does not have access to your camera. To enable access, tap settings and turn on Camera."
    static let alertForVideoLibraryMessage = "App does not have access to your video. To enable access, tap settings and turn on Video Library Access."
    static let settingsBtnTitle = "Settings"
    static let cancelBtnTitle = "Cancel"
    
}
enum AttachmentType: String{
    case camera, photoLibrary
}

extension NSString
{
    func isMaxmiumString(maxLength :Int, range :NSRange,string :String) -> Bool
    {
        let currentString: NSString = self
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func isMinimumString(minLength :Int, range :NSRange,string :String) -> Bool
    {
        let currentString: NSString = self
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= minLength
    }
}


