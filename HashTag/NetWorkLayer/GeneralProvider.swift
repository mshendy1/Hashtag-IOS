
//
//  GeneralProvider.swift
//  medexa
//
//  Created by Mohamed Shendy on 6/27/21.
//
import Moya
import UIKit
import SwiftyJSON
import LanguageManager_iOS

enum GeneralProvider {
    case login(name: String,password: String,firebaseToken: String,device:String)
    case visitor(firebaseToken: String,device:String)
    case refreshFCMToken(userId: Int,firebaseToken: String)
    case socialLogin(providerName:String,providerId:String,name:String,email:String,device:String)
    case registerStepOne(name: String,email:String,password: String,phone:String,device:String)
    case registerStepTwo(genderId: Int,dateOfBirth:String)
    case profile
    case getCategory
    case getTags
    case addCategory(categoryId:[Int])
    case sendCode(phone:String,email:String)
    case checkCode(code:String,phone:String,email:String)
    case updatePassword(password: String,phone:String,email:String,passwordConfirmation:String)
    //MARK:- HOME
    case getAds
    //MARK:- HOME TREND
    case trendsTwitter
    case trendsYoutube
    case trendsGoogle
    case trendsNews
    //MARK:- HOME EVENTS
    case  getAllEvents
    case getCountry
    case eventType
    //MARK:- HOME NEWS

    case getHomePoll
    case getPostDetails(id:Int,deviceId:String)
    case addComment(comment:String,postId:Int)
    case getEventDetails(id:Int,deviceId:String)
    case addLike(id:Int,deviceId:String)
    case SearchResult(query:String)
    case SearchOuts(query:String)
    case getMyEvents
    case getNotificatios
    case turnNotificatios(id:Int,deviceId:String)
    case addPoll(id:Int,surveyId:Int,device:String)
    case showPolldetails(surveyId:Int,deviceId:String)
    case getProfile
    case getCommonQues
    case getContactUs
    case sendContactUs(email:String,device:String,desc:String)
    case logout
    case getTerms
    case getPrivacy
    case createEvent(eventImage: UIImage?,eventVideo:URL? ,params: [String : Any])
    case addFavPosts(postId:Int,deviceId:String)
    case addFavEvents(eventId:Int,deviceId:String)
    case addFavPolls(pollId:Int,deviceId:String)
    case getFavPosts(deviceId:String)
    case getFavEvents(deviceId:String)
    case getFavPolls(deviceId:String)
}


extension GeneralProvider: TargetType {
    var baseURL: URL {
        Environment.baseUrl
    }
    
    var path: String {
        switch self {
        case .refreshFCMToken:
            return "updateFirebaseToken"
        case .login:
            return "login"

        case .visitor:
        return "guestUserStore"
            
        case .socialLogin:
            return "provider"

        case .registerStepOne:
            return "registerStepOne"
            
        case .registerStepTwo:
            return "registerStepTwo"
             
        case .profile:
            return "profile"
            
        case .getCategory:
            return "getCategory"
            
        case .addCategory:
            return "addCategory"
            
        case .sendCode:
            return "sendCode"
         
        case .checkCode:
            return "checkCode"
            
        case .updatePassword:
            return "updatePassword"
           
    //---------MARK:- HOME
        case  .getAds:
            return "ads"
         
    //---------MARK:- HOME TREND
        case .trendsYoutube:
            return "trends/youtube"
        
        case .trendsTwitter:
            return "trends/twitterGetTrends"
            
        case .trendsGoogle:
            return "trends/google_trends"
            
        case .trendsNews:
            return "trends/google_news"
        
    //---------MARK:-HOME EVENTS
        case.getAllEvents:
            return "getEvents"
        case .getCountry:
            return "getCity"
      
        case .eventType:
            return "event_type"
        case  .getHomePoll:
            return "poll"
        case .getPostDetails:
            return "posts/show"
        case .addComment:
            return "comment"
        case .getEventDetails:
            return "events/showEvent"
       // posts
        case .addLike:
            return "posts/like"

        case .SearchResult:
            return "search/suggest"
        case .SearchOuts:
            return "search"
        case .getMyEvents:
            return "events/myEvents"
        case .getNotificatios:
            return "notification"
        case .turnNotificatios:
            return "turn_notification"
            
        case .showPolldetails:
            return "poll/show"
        case .addPoll:
            return "sendPollItem"
        case .getProfile:
            return "profile"
        case .getCommonQues:
            return "fqa"
        case .getContactUs:
            return "contactUs"
        case .sendContactUs:
            return "contactUs"
        case .logout:
            return "logout"
        case .getTerms:
            return "terms"
        case .getPrivacy:
            return "privacy"
            
        case .createEvent:
            return "events"
        case .getTags:
            return"getTags"
    //MARK:-FAVOURITES
        case .addFavPosts:
            return "posts/bookmark"
        case .addFavEvents:
            return "events/bookmark"
        case .addFavPolls:
            return "poll/bookmark"

        case .getFavPosts:
            return"bookmark/getPosts"
        case .getFavEvents:
            return "bookmark/getEvents"
        case .getFavPolls:
            return"bookmark/getPolls"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login,.registerStepOne,.registerStepTwo,.addCategory, .sendCode,.checkCode,.updatePassword,.getAllEvents,.getPostDetails,.addComment,.getEventDetails,.addLike,.SearchOuts,.SearchResult,.addFavPosts,.addFavEvents,.addFavPolls,.addPoll,.showPolldetails,.sendContactUs,.getHomePoll,.createEvent ,.getFavPosts,.getFavPolls,.getFavEvents,.socialLogin,.refreshFCMToken,.visitor,.turnNotificatios:
            return .post
         
        case .getCategory,.trendsYoutube,.trendsTwitter,.trendsGoogle ,.trendsNews,.getCountry,.eventType,.getAds,.profile,.getMyEvents,.getNotificatios,.getProfile,.getCommonQues,.getContactUs,.logout,.getTerms,.getPrivacy,.getTags:
            return .get
    
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case let .refreshFCMToken(userId, firebaseToken):
            let paramters = ["id":userId,"firebase_token":firebaseToken] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
            
        case let .login(name, password, firebaseToken,device):
            let paramters = ["name":name,"password":password,"firebase_token": firebaseToken,"device_id":device]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)

        case let .visitor(firebaseToken,device):
            let paramters = ["firebase_token": firebaseToken,"device_id":device]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)

        case let .socialLogin(providerName, providerId, name, email,device):
            let paramters = ["provider_name":providerName,"provider_id":providerId,"name":name,"email":email,"device_id":device] as [String : String]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)

        case let .registerStepOne(name,email, password,phone,device):
            let paramters = ["name":name,
                             "password":password,
                             "email":email,
                             "phone":phone,"device_id":device] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
            
        case let .registerStepTwo(genderId, dateOfBirth):
            let paramters = ["date_of_birth":dateOfBirth,
                             "gender_id":genderId] as [String : Any]
            
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
            
            
        case let .addCategory(categoryId):
            let paramters = ["category_id":categoryId] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
            
        case let .sendCode(phone,email):
            let paramters = ["phone":phone,"email":email] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
            
        case let .checkCode(code,phone,email):
            let paramters = ["code":code,"phone":phone,"email":email] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
            
        case let .updatePassword(password,phone,email,passwordConfirmation):
            let paramters = ["password":password,
                             "password_confirmation":passwordConfirmation,
                             "phone":phone,"email":email] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)

        case .getAllEvents:
            let paramters = [:] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
                    
        case let .getPostDetails(id,deviceId):
            let paramters = ["id":id,"session":deviceId] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        
        case let .addComment(comment, postId):
            let paramters = ["comment":comment,"post_id":postId] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
       
        case let .getEventDetails(id,deviceId):
            let paramters = ["event_id":id,"device_id":deviceId] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)

        case let .addLike(id,deviceId):
            let paramters = ["id":id,"device_id":deviceId] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        
        case let .SearchOuts(query):
            let paramters = ["query":query] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        
        case let .SearchResult(query):
            let paramters = ["query":query] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        
        case let .addFavPosts(postId,deviceId):
            let paramters = ["id":postId,"device_id":deviceId,"device":"ios"] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
       
        case let .addFavEvents(eventId,deviceId):
            let paramters = ["id":eventId,"device_id":deviceId,"device":"ios"] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
      
        case let .addFavPolls(pollId,deviceId):
            let paramters = ["id":pollId,"device_id":deviceId,"device":"ios"] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
       
        case let .addPoll(id,surveyId,device):
            let paramters = ["id":id,"servey_id":surveyId,"device":"ios"] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        
        case let .showPolldetails(surveyId,deviceId):
            let paramters = ["servey_id":surveyId,"device_id":deviceId] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
       
        case let .sendContactUs(email,device,desc):
            let paramters = ["email":email,"device":device,"des":desc] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)

        case let .getFavPosts(deviceId):
            let paramters = ["device_id":deviceId,"device":"ios"] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)

        case let .getFavPolls(deviceId):
            let paramters = ["device_id":deviceId,"device":"ios"] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
       
        case let .getFavEvents(deviceId):
            let paramters = ["device_id":deviceId,"device":"ios"] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        case .getHomePoll:
            let paramters = [:] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
       
        case let .turnNotificatios(id,deviceId):
            let paramters = ["id":id,"device_id":deviceId] as [String : Any]
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        case .getCategory,.trendsYoutube,.trendsTwitter,.trendsGoogle,.trendsNews,.getCountry,.eventType,.getAds,.profile,.getMyEvents,.getNotificatios,.getProfile,.getCommonQues,.getContactUs,.logout,.getTerms,.getPrivacy,.getTags:
            return .requestPlain
        case let .createEvent(eventImage, eventVideo,params):
            
            var multipartData :[MultipartFormData] = []
            
            for p in params {
                let content = MultipartFormData(provider: .data("\(p.value)".data(using: .utf8)!), name: p.key)
                multipartData.append(content )
            }
            
          
            if eventImage != nil {
                let data = General.compressImage(image: eventImage!)
                let imgData = MultipartFormData(provider: .data(data), name: "file", fileName: "assets.png", mimeType: "image/png")
                multipartData.append(imgData)
                
                
                
                return .uploadMultipart(multipartData)

            }
            else if eventVideo != nil {
                let fullNameArr = "\(eventVideo!)".components(separatedBy: "://")

                let url  = URL(fileURLWithPath:fullNameArr[1])
                print(url)

                let file = NSData(contentsOf: url)
                let fileData = Data(referencing: file!)

                let videoData = MultipartFormData(provider: .data(fileData), name: "file", fileName: "assets.png", mimeType: "image/png")
                multipartData.append(videoData)
                
                return .uploadMultipart(multipartData)
            }
            else
            {
                return .uploadMultipart(multipartData)
            }
       
            

        
        }//end of swich
        
    }
    
    
    var headers: [String : String]? {
       
        if  UserData.shared.token != nil {
            return ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":UserData.shared.token!]
        }else{
            return ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json"]
        }
    }
    
    
}
