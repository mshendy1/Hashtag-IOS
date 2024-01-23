//
//  FavouritesNetworkManager.swift
//  HashTag
//
//  Created by Eman Gaber on 26/02/2023.
//

import Foundation
import Alamofire
import Moya

class FavouritesNetworkManager{

    static let Favouritesprovider =
    MoyaProvider<GeneralProvider>(plugins: [NetworkLoggerPlugin()])
    
    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    
    
    static func getFavPostsApi(deviceId: String,completion:@escaping(_ response: FavPostsResponse?, _ error: Error?) -> Void) {
        FavouritesNetworkManager.Favouritesprovider.request(.getFavPosts(deviceId:deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(FavPostsResponse.self, from: response.data )
                    //print(result)
                    if result.status == true{
                        let myObject = result.data?.data
                        do {
                            let jsonData = try JSONEncoder().encode(myObject)
                           // UserData.shared.saveUser(from:jsonData)
                         //   print(jsonData)
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
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func getFavEventsApi(deviceId: String,completion:@escaping(_ response: FavEventsResponse?, _ error: Error?) -> Void) {
        FavouritesNetworkManager.Favouritesprovider.request(.getFavEvents(deviceId:deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(FavEventsResponse.self, from: response.data )
                    //print(result)
                    if result.status == true{
                        let myObject = result.data?.data
                        do {
                            let jsonData = try JSONEncoder().encode(myObject)
                           // UserData.shared.saveUser(from:jsonData)

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
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    static func getFavPollsApi(deviceId: String,completion:@escaping(_ response: FavPollsResponse?, _ error: Error?) -> Void) {
        FavouritesNetworkManager.Favouritesprovider.request(.getFavPolls(deviceId:deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(FavPollsResponse.self, from: response.data )
                    //print(result)
                    if result.status == true{
                        let myObject = result.data?.data
                        do {
                            let jsonData = try JSONEncoder().encode(myObject)
                      //      UserData.shared.saveUser(from:jsonData)

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
                    print("ResponseUserDetails parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func getSearchApi(query:String,completion:@escaping(_ response: SearchOutResponse?, _ error: Error?) -> Void) {
        FavouritesNetworkManager.Favouritesprovider.request(.SearchOuts(query: query)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(SearchOutResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get SearchOutResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
}
