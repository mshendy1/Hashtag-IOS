//
//  NotificationNetworkigManager.swift
//  HashTag
//  Created by Eman Gaber on 27/02/2023.
//

import Foundation
import Foundation
import Moya
import Alamofire

class NotificationNetworkigManager{
    
    static let NotificationProvider =
    MoyaProvider<GeneralProvider>(plugins: [NetworkLoggerPlugin()])
    
    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static func getNotificationsApi(completion:@escaping(_ response: NotificationResponse?, _ error: Error?) -> Void) {
        NotificationNetworkigManager.NotificationProvider.request(.getNotificatios) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(NotificationResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Notifications  parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
//    static func switchNotificationsApi(completion:@escaping(_ response: SwitchNotificationResponse?, _ error: Error?) -> Void) {
//        NotificationNetworkigManager.NotificationProvider.request(.turnNotificatios) { (result) in
//            switch result {
//            case .success(let response):
//                do {
//                    let result = try jsonDecoder.decode(SwitchNotificationResponse.self, from: response.data )
//                    
//                    if result.status == true{
//                        completion(result, nil)
//                    }
//                    else{
//                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
//                        completion(nil, error)
//                    }
//                } catch {
//                    print("turn Notifications  parse error: \(error)")
//                    completion(nil, error)
//                }
//            case .failure(_):
//                
//                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
//                completion(nil, error)
//            }
//        }
//    }
    
    
    
    static func switchNotificationsApi(id:Int,device:String,completion:@escaping(_ response: SwitchNotificationResponse?, _ error: Error?) -> Void) {
        NotificationNetworkigManager.NotificationProvider.request(.turnNotificatios(id: id,deviceId: device)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(SwitchNotificationResponse.self, from: response.data )
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("send PollItem API error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
}
