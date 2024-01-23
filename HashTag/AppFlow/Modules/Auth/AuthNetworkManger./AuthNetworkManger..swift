

//
//  AuthNetworkManger..swift
//  HashTag
//
//  Created by Eman Gaber on 18/02/2023.
//

import Foundation
import Alamofire
import Moya

class AuthNetworkManger{
    static let authProvider =
    MoyaProvider<GeneralProvider>(plugins: [NetworkLoggerPlugin()])
    
    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    //-----------------------( Auth )------------------//
    
    static func refreshFCMTokenApi(id: Int,fcmToken: String,completion:@escaping(_ response: GeneralResponse?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.refreshFCMToken(userId: id,firebaseToken: fcmToken)) { (result) in
            
            switch result {
                
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(GeneralResponse.self, from: response.data )
                    //print(result)
                    if result.status == true{
                        let myObject = result.data?.data
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "" ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func SocialLoginApi(providerName: String,providerId: String,name:String,email:String,device:String,completion:@escaping(_ response: ResponseUserDetails?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.socialLogin(providerName:providerName, providerId:providerId,name:name,email:email,device: device)) { (result) in
            
            switch result {
                
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(ResponseUserDetails.self, from: response.data )
                    //print(result)
                    if result.status == true{
                        let myObject = result.data?.data
                        do {
                            let jsonData = try JSONEncoder().encode(myObject)
                            UserData.shared.saveUser(from:jsonData)

                            print(jsonData)
                        } catch {
                            print(error.localizedDescription)
                        }
                        //UserData.shared.saveUser(from:response.data)
                        UserData.shared.token = result.data?.token?.accessToken ?? ""
                        UserDefaults.standard.setMobileToken(value: result.data?.token?.accessToken ?? "")
                        UserDefaults.standard.setNotifiaction(value:(result.data?.data?.turnNotification)! )
                        UserDefaults.standard.setValue(1 , forKey: "isLogin")
                        UserDefaults.standard.setLoggedIn(value: true)
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    static func loginApi(name: String,password: String,firebaseToken: String,deviceId:String,completion:@escaping(_ response: ResponseUserDetails?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.login(name: name, password: password,firebaseToken:firebaseToken, device: deviceId)) { (result) in
            
            switch result {
                
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(ResponseUserDetails.self, from: response.data )
                    //print(result)
                    if result.status == true{
                        let myObject = result.data?.data
                        do {
                            let jsonData = try JSONEncoder().encode(myObject)
                            UserData.shared.saveUser(from:jsonData)
                            print(jsonData)
                        } catch {
                            print(error.localizedDescription)
                        }
                        //UserData.shared.saveUser(from:response.data)
                        UserData.shared.token = result.data?.token?.accessToken ?? ""
                        UserDefaults.standard.setValue(1 , forKey: "isLogin")
                        UserDefaults.standard.setLoggedIn(value: true)
                        UserDefaults.standard.setNotifiaction(value:(result.data?.data?.turnNotification)! )
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func getGuestUserApi(firebaseToken: String,device:String,completion:@escaping(_ response: GuestResponse?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.visitor(firebaseToken:firebaseToken,device:device)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(GuestResponse.self, from: response.data )
                    
                    if result.status == true{
                        UserDefaults.standard.setNotifiaction(value:(result.data?.turnNotification)!)
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    static func registerStepOneApi(name: String,email:String,password: String,phone:String,deviceId:String,completion:@escaping(_ response: ResponseUserDetails?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.registerStepOne(name: name,email: email, password:password,phone: phone,device: deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(ResponseUserDetails.self, from: response.data )
                    if result.status == true{
                        UserData.shared.token = result.data?.token?.accessToken ?? ""
                        completion(result, nil)
                    }
                    else if result.status == false{
                        completion(result, nil)
                    }else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil,error)
                }
            case .failure(_):
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error )
            }
        }
    }
    
    
    static func registerStepTwoApi(genderId: Int,dateOfBirth:String,completion:@escaping(_ response: ResponseUserDetails?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.registerStepTwo(genderId: genderId, dateOfBirth: dateOfBirth)) { (result) in
            
            switch result {
                
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(ResponseUserDetails.self, from: response.data )
                    //print(result)
                    if result.status == true{
                        UserData.shared.saveUser(from:response.data)
                        //                        UserData.shared.token = result.data?.token?.accessToken ?? ""
                        
                        UserDefaults.standard.setValue(1 , forKey: "isLogin")
                        
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func getProfileApi(completion:@escaping(_ response: ResponseUserDetails?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.profile) { (result) in
            
            switch result {
                
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(ResponseUserDetails.self, from: response.data )
                    //print(result)
                    if result.status == true{
                        
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    static func getTagsApi(completion:@escaping(_ response: getTagsResponse?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.getTags) { (result) in
            
            switch result {
                
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(getTagsResponse.self, from: response.data )
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("GetCategoryResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    static func getCategoryApi(completion:@escaping(_ response: GetCategoryResponse?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.getCategory) { (result) in
            
            switch result {
                
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(GetCategoryResponse.self, from: response.data )
                    
                    if result.status == true{
                        
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("GetCategoryResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    static func addCategoryApi(categoryId:[Int],completion:@escaping(_ response: AddCategoryResponse?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.addCategory(categoryId:categoryId)) { (result) in
            
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(AddCategoryResponse.self, from: response.data )
                    
                    if result.status == true{
                        
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("AddCategoryResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
//    static func emailSendCodeApi(phone:String,email:String,completion:@escaping(_ response: EmailSendCodeResponse?, _ error: Error?) -> Void) {
//
//        AuthNetworkManger.authProvider.request(.sendCode(phone:phone,email:email)) { (result) in
//
//            switch result {
//            case .success(let response):
//                do {
//                    let result = try jsonDecoder.decode(EmailSendCodeResponse.self, from: response.data )
//                    if result.status == true{
//                        completion(result, nil)
//                    }
//                    else{
//                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
//                        completion(nil, error)
//                    }
//                } catch {
//                    print("SendCodeResponse parse error: \(error)")
//                    completion(nil, error)
//                }
//            case .failure(_):
//
//                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
//                completion(nil, error)
//            }
//        }
//    }
    static func sendCodeApi(phone:String,email:String,completion:@escaping(_ response: SendCodeResponse?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.sendCode(phone:phone,email:email)) { (result) in
            
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(SendCodeResponse.self, from: response.data )
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("SendCodeResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func checkCodeApi(code:String,phone:String,email:String,completion:@escaping(_ response: GeneralResponse?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.checkCode(code: code, phone:phone,email:email)) { (result) in
            
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
                    print("GeneralResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    static func updatePasswordApi(password: String,email:String,phone:String,passwordConfirmation:String,completion:@escaping(_ response: GeneralResponse?, _ error: Error?) -> Void) {
        
        AuthNetworkManger.authProvider.request(.updatePassword(password: password, phone: phone,email:email,passwordConfirmation: passwordConfirmation)) { (result) in
            
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
                    print("GeneralResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
}
    
