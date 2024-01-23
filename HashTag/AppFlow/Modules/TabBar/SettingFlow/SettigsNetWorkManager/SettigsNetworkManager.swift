//
//  SettigsNetWorkManager.swift
//  HashTag
//
//  Created by Eman Gaber on 27/02/2023.
//


import Foundation
import Moya
import Alamofire
import UIKit
import SwiftyJSON
import LanguageManager_iOS
class SettingsNetworkManager{

    static let Settingsprovider =
    MoyaProvider<GeneralProvider>(plugins: [NetworkLoggerPlugin()])
    
    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static func getMyEventsApi(completion:@escaping(_ response: MyEventsResponse?, _ error: Error?) -> Void) {
        SettingsNetworkManager.Settingsprovider.request(.getMyEvents) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(MyEventsResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Fav News parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
 
    
    static func getCommonQuesApi(completion:@escaping(_ response: CommonQuesResponse?, _ error: Error?) -> Void) {
        SettingsNetworkManager.Settingsprovider.request(.getCommonQues) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(CommonQuesResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Fav News parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    static func getContactUsApi(completion:@escaping(_ response: ContactUsResponse?, _ error: Error?) -> Void) {
        SettingsNetworkManager.Settingsprovider.request(.getContactUs) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(ContactUsResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Fav News parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    static func getProfileApi(completion:@escaping(_ response: ProfilResponse?, _ error: Error?) -> Void) {
        SettingsNetworkManager.Settingsprovider.request(.getProfile) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(ProfilResponse.self, from: response.data )
                    
                    if result.status == true{
                        let myObject = result.data?.user
                        do {
                            let jsonData = try JSONEncoder().encode(myObject)
                            UserData.shared.saveUser(from:jsonData)

                            print(jsonData)
                        } catch {
                            print(error.localizedDescription)
                        }
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Fav News parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    class func callUpdateProfileAPI(Url: String, userImage: UIImage? ,params: [String : Any], compilition : @escaping (_ response : Bool ,_ message:String)->Void){
 
        guard let token = UserData.shared.token else{return}
        let headers : HTTPHeaders = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":UserData.shared.token!]
        
        let encodedURL = Url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for p in params {
                multipartFormData.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            
            if userImage != nil {
                let data = General.compressImage(image: userImage!)
                multipartFormData.append(data, withName: "photo", fileName: "profileimage.png", mimeType: "image/png")
            }
        }, to: encodedURL!,usingThreshold: UInt64.init(),method: .post, headers: headers).uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            
        }
        ).response { (response) in
            switch response.result {
            case .success(let resut):
                
                let json = JSON(resut!)
                print(json)
                
                if json["success"] == false {
                    compilition(false, "\(json["msg"])")
                }else
                {
                    let jsonData = Data("\(json)".utf8)

                    let decoder = JSONDecoder()
                    do {
                        let userData = try decoder.decode(EditeProfilRespons.self, from: jsonData)

                    } catch {
                        print(error.localizedDescription)
                    }
                    compilition(true, "Update_Profile_success".localiz())
                }
            case .failure(let err):
                compilition(false, "error".localiz())
            }
        }
    }
    
    
    static func sendContactUsRequestApi(email:String,device:String,desc:String,completion:@escaping(_ response: GeneralResponse?, _ error: Error?) -> Void) {
        
        SettingsNetworkManager.Settingsprovider.request(.sendContactUs(email: email, device: device, desc: desc)) { (result) in
            
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(GeneralResponse.self, from: response.data )
                    
                    if result.status == true{
                        
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("Send ContactUs requestResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func logoutApi(completion:@escaping(_ response: GeneralResponse?, _ error: Error?) -> Void) {
        SettingsNetworkManager.Settingsprovider.request(.logout) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(GeneralResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Fav News parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    static func getTermsApi(completion:@escaping(_ response: TermsResponse?, _ error: Error?) -> Void) {
        SettingsNetworkManager.Settingsprovider.request(.getTerms) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(TermsResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Fav News parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
        
    
    static func getPrivacyApi(completion:@escaping(_ response: PrivacyResponse?, _ error: Error?) -> Void) {
        SettingsNetworkManager.Settingsprovider.request(.getPrivacy) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(PrivacyResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Fav News parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
}
