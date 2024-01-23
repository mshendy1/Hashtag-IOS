//
//  HomeNetWorkManager.swift
//  HashTag
//
//  Created by Eman Gaber on 18/02/2023.
//

import Foundation
import Moya
import Alamofire
import LanguageManager_iOS
import SwiftyJSON
import UIKit
class HomeNetWorkManager{
    
    static let Homeprovider =
    MoyaProvider<GeneralProvider>(plugins: [NetworkLoggerPlugin()])
    
    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    
    
    
    static func getTrendsYoutubeApi(completion:@escaping(_ response: TrendYoutubeResponse?, _ error: Error?) -> Void) {
        
        HomeNetWorkManager.Homeprovider.request(.trendsYoutube) { (result) in
            
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(TrendYoutubeResponse.self, from: response.data )
                    
                    if result.status == true{
                        
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "" ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("Trend Youtube Response parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func getTrendsGoogleApi(completion:@escaping(_ response: TrendGoogleResponse?, _ error: Error?) -> Void) {
        
        HomeNetWorkManager.Homeprovider.request(.trendsGoogle) { (result) in
            
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(TrendGoogleResponse.self, from: response.data )
                    
                    if result.status == true{
                        
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("TrendGoogleResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    static func getTrendsTwitterApi(completion:@escaping(_ response: TrendTwitterResponse?, _ error: Error?) -> Void) {
        
        HomeNetWorkManager.Homeprovider.request(.trendsTwitter) { (result) in
            
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(TrendTwitterResponse.self, from: response.data )
                    
                    if result.status == true{
                        
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "" ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("TrendTwitterResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    static func getTrendsNewsApi(completion:@escaping(_ response: TrendGoogleNewsResponse?, _ error: Error?) -> Void) {
        
        HomeNetWorkManager.Homeprovider.request(.trendsNews) { (result) in
            
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(TrendGoogleNewsResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "" ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("TrendNewsResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    static func getCountriesApi(completion:@escaping(_ response: CountryResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.getCountry) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(CountryResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "" ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("Get Country Response parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    static func getEventsTypesApi(completion:@escaping(_ response: EventsTypesResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.eventType) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(EventsTypesResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "" ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("Get Events Types Response parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    static func getAllEventsApi(completion:@escaping(_ response: EventsResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.getAllEvents) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(EventsResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get all Events parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    static func getAdsApi(completion:@escaping(_ response: AdsResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.getAds) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(AdsResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Ads parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func searchResultApi(text:String,completion:@escaping(_ response: SearchSuggetResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.SearchResult(query:text)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(SearchSuggetResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Search parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    static func getPostDetailsApi(id:Int,deviceId:String,completion:@escaping(_ response: PostDetailsResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.getPostDetails(id:id, deviceId: deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(PostDetailsResponse.self, from: response.data )
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message  ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Post details parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    static func addCommentApi(comment:String,postId:Int,completion:@escaping(_ response: CommentsResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.addComment(comment: comment, postId: postId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(CommentsResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message  ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("add Comments parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    static func getHomePollsApi(completion:@escaping(_ response: PollResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.getHomePoll) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(PollResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message  ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Home polls parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    static func getEventDetailsApi(id:Int,deviceId:String,completion:@escaping(_ response: EventDetailsResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.getEventDetails(id:id, deviceId: deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(EventDetailsResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message  ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Events Details parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func likePostApi(id:Int,deviceId:String,completion:@escaping(_ response: LikePostResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.addLike(id:id,deviceId:deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(LikePostResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("LikePostResponse parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    
    
    static func addFavPostApi(id:Int,deviceId:String,completion:@escaping(_ response: AddFavouritesResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.addFavPosts(postId:id,deviceId:deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(AddFavouritesResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "" ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Search parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    static func addFavEventApi(id:Int,deviceId:String ,completion:@escaping(_ response: AddFavouritesResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.addFavEvents(eventId:id,deviceId:deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(AddFavouritesResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Search parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    static func addFavPollApi(id:Int,deviceId:String,completion:@escaping(_ response: AddFavouritesResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.addFavPolls(pollId: id,deviceId:deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(AddFavouritesResponse.self, from: response.data )
                    
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Search parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
    
    static func showPolldetailsAPI(surveyID:Int,deviceId:String,completion:@escaping(_ response: PollsDetailsResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.showPolldetails(surveyId:surveyID, deviceId: deviceId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(PollsDetailsResponse.self, from: response.data )
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "" ]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("get Search parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }


    
    
    static func sendPollAPI(id:Int,surveyID:Int ,device:String,completion:@escaping(_ response: PollsDetailsResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.addPoll(id: id, surveyId: surveyID, device: device)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(PollsDetailsResponse.self, from: response.data )
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
    
    
    
    
    static func createEventAPI(eventImage: UIImage?,eventVideo:URL? ,params: [String : Any],completion:@escaping(_ response: GeneralResponse?, _ error: Error?) -> Void) {
        HomeNetWorkManager.Homeprovider.request(.createEvent(eventImage: eventImage, eventVideo: eventVideo, params: params)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try jsonDecoder.decode(GeneralResponse.self, from: response.data )
                    if result.status == true{
                        completion(result, nil)
                    }
                    else{
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? ""]) as Error
                        completion(nil, error)
                    }
                } catch {
                    print("call Create Event API parse error: \(error)")
                    completion(nil, error)
                }
            case .failure(_):
                
                let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey:"Error_happened".localiz()]) as Error
                completion(nil, error)
            }
        }
    }
    
}

