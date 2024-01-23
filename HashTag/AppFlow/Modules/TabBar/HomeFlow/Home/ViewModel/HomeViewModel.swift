//
//  HomeViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 22/07/1444 AH.
//

import Foundation
import Alamofire
import LanguageManager_iOS
import SwiftyJSON
import UIKit


@objc protocol HomeOutputDelegate{
    func newsTapped()
    func trendTapped()
    func surveysTapped()
    func eventTapped()
    func youtubeTapped(url:String)
    func trendGoogleNewsTapped(url:String)
    func trendGoogleTapped(url:String)
    func trendTwitterTapped(tex:String)
    func moveToEventDetails(id:Int)
    func moveToSearch()
    func reloadPosts()
    func reloadEventsData()
    func reloadPollsData()
    func newsFilterTapped()
    func eventsFilterTapped()
    func moveToPollDetails(id: Int)
    func moveToPostDetails(id:Int)
    func moveToVideoDetails(id:Int,videoUrl:String?,video:String?)
    func createEventTapped()
}
 protocol HomeViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func setLocalization()
    func moveToLogin()
    func getCountriesSuccessfully(countriesModel:[CountriesModel?]?)
    func getEventsTypesSuccessfully(typesModel:[TypesModel]?)
    func getEventsSuccessfully(event:[EventModel?]?)
    func getFilterEventsSuccessfully(event:[EventModel?]?)
    func likePostSuccessfully(index:Int)
    func addToFavSuccessfully(index:Int,type:Types)
    func getTwitterTrendSuccessfully(model:[TrendTwitterModel?]?)
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegates?
    weak var outputDelegate: HomeOutputDelegate?

    init(delegate:HomeViewModelDelegates,outputDelegate:HomeOutputDelegate) {
        self.delegate = delegate
        self.outputDelegate = outputDelegate
    }
    
    var trendYoutubeArray: [TrendYoutubeModel?]?
    var trendGoogleArray: [TrendGoogleModel?]?
    var trendTwitterArray: [TrendTwitterModel?]?
    var trendGoogleNewsArray: [TrendGoogleNewsModel?]?
    var eventsTypesArray: [TypesModel]?
    var eventsArray: [EventModel?]?
    var filterArray:[EventModel?]?
    var adsArray: [AdsModel?]?
    var postsArray: [NewsPostsModel?]?
    var pollsArray: [PollModel?]?
    var countriesArray: [CountriesModel?]?
    var lastPageForPosts :Int?
    var lastPageForEvents :Int?
    var lastPageForPolls :Int?
    var postsIsPagination = false
    var pollsIsPagination = false
    var eventsIsPagination = false
    var postsBookmarkArry :[Bool] = []
    var eventsBookmarkArry :[Bool] = []
    var pollsBookmarkArry :[Bool] = []


    func callGetTrendsYoutubeApi(){
        self.delegate?.showLoading()
        HomeNetWorkManager.getTrendsYoutubeApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.trendYoutubeArray = model?.data
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func callGetTrendsTwitterApi(){
        self.delegate?.showLoading()
        HomeNetWorkManager.getTrendsTwitterApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.trendTwitterArray = model?.data
                self.delegate?.getTwitterTrendSuccessfully(model:self.trendTwitterArray ?? [])
            }else if (error != nil) {
                //                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func callGetTrendsGoogleApi(){
        self.delegate?.showLoading()
        HomeNetWorkManager.getTrendsGoogleApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.trendGoogleArray = model?.data
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func callGetTrendsNewsApi() {
        self.delegate?.showLoading()
        HomeNetWorkManager.getTrendsNewsApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.trendGoogleNewsArray = model?.data
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func likePostApi(id:Int,index:Int,deviceId:String) {
        self.delegate?.showLoading()
        HomeNetWorkManager.likePostApi(id: id,deviceId: deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.likePostSuccessfully(index:index)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    
    
    func addPostsToFavApi(id:Int,index: Int,deviceId:String) {
        // self.delegate?.showLoading()
        HomeNetWorkManager.addFavPostApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully(index: index, type: .news)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    func addPollsToFavApi(id:Int,index: Int,deviceId:String) {
        // self.delegate?.showLoading()
        HomeNetWorkManager.addFavPollApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully(index: index, type: .surveys)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func addEventToFavApi(id:Int,index: Int,deviceId:String) {
        //self.delegate?.showLoading()
        HomeNetWorkManager.addFavEventApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully(index: index, type: .events)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func callGetCountriesApi() {
        self.delegate?.showLoading()
        HomeNetWorkManager.getCountriesApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.countriesArray = model?.data?.data
                self.delegate?.getCountriesSuccessfully(countriesModel: self.countriesArray ?? [])
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func callGetTypessApi() {
        self.delegate?.showLoading()
        HomeNetWorkManager.getEventsTypesApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.eventsTypesArray = model?.data
                self.delegate?.getEventsTypesSuccessfully(typesModel: self.eventsTypesArray ?? [])
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    

    func callGetEventsApiFilter(categryId: [Int]?,countryId: [Int]?,date:String?){
        var headers : HTTPHeaders = [:]
        if  UserData.shared.token != nil {
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":UserData.shared.token!]
        }else{
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json"]
        }
        
        let Url = "\(Environment.baseUrl)getEvents"
        let encodedURL = Url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            if date != nil{
                multipartFormData.append("\(date!)".data(using: String.Encoding.utf8)!, withName: "date")
            }
            
            let deviceId = UserData.shared.deviceId ?? ""
            if !UserDefaults.standard.isLoggedIn() {
                multipartFormData.append((deviceId.data(using: String.Encoding.utf8)!), withName: "device_id")
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
                }else {
                    let jsonData = Data("\(json)".utf8)
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(EventsResponse.self, from: jsonData)
                        print(data)
                        self.eventsArray = data.data?.data
                        
                        self.delegate?.getEventsSuccessfully(event: self.eventsArray ?? [])
                        // compilition(true, "")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let err):
                print("error".localiz())
            }
        }
    }
 
    
    func callGetPostsApi(category_id: [Int],tag_id:[Int],page:Int){
        postsIsPagination = true
        self.delegate?.showLoading()
        var headers : HTTPHeaders = [:]
        
        if UserDefaults.standard.isLoggedIn() {
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":UserData.shared.token!]
        }else{
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":""]
        }
        let Url = "\(Environment.baseUrl)postAll?page=\(page)"
        let encodedURL = Url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        AF.upload(multipartFormData: { (multipartFormData) in
            var fullIdstr = ""
            for id in category_id {
                fullIdstr.append("\(id)")
                fullIdstr.append(",")
            }
            if fullIdstr.count > 0 {
                fullIdstr.removeLast()
                multipartFormData.append(fullIdstr.data(using: String.Encoding.utf8)!, withName: "category_id[]")
            }
            
            let deviceId = UserData.shared.deviceId ?? ""
            if !UserDefaults.standard.isLoggedIn() {
                multipartFormData.append((deviceId.data(using: String.Encoding.utf8)!), withName: "device_id")
            }
            
        }, to: encodedURL!,usingThreshold: UInt64.init(),method: .post, headers: headers).uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in  }).response { (response) in
            self.delegate?.killLoading()
            switch response.result {
            case .success(let resut):
                let json = JSON(resut!)
                print(json)
                if json["success"] == false {
                }else{
                    let jsonData = Data("\(json)".utf8)
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(NewsPostsResponse.self, from: jsonData)
                        print(data)
                        if page == 1 {
                            self.postsArray = data.data?.data
                        }else {
                            self.postsArray?.append(contentsOf: data.data?.data ?? [])
                        }
                        self.postsBookmarkArry = []
                        for post in self.postsArray ?? []
                        {
                            self.postsBookmarkArry.append(post?.bookmark ?? false)
                        }
                        self.lastPageForPosts = data.data?.meta?.lastPage ?? 1
                        self.outputDelegate?.reloadPosts()
                        self.postsIsPagination = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let err):
                print("error".localiz())
            }
        }
    }
    
    
    func callGetEventsApi(category_id: [Int],tag_id:[Int],page:Int){
        eventsIsPagination = true
        self.delegate?.showLoading()
        var headers : HTTPHeaders = [:]
        
        if UserDefaults.standard.isLoggedIn() {
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":UserData.shared.token!]
        }else{
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":""]
        }
        let Url = "\(Environment.baseUrl)getEvents?page=\(page)"
        let encodedURL = Url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        AF.upload(multipartFormData: { (multipartFormData) in
            var fullIdstr = ""
            for id in category_id {
                fullIdstr.append("\(id)")
                fullIdstr.append(",")
            }
            
            if fullIdstr.count > 0 {
                fullIdstr.removeLast()
                multipartFormData.append(fullIdstr.data(using: String.Encoding.utf8)!, withName: "category_id[]")
            }
            
            let deviceId = UserData.shared.deviceId ?? ""
            if !UserDefaults.standard.isLoggedIn() {
                multipartFormData.append((deviceId.data(using: String.Encoding.utf8)!), withName: "device_id")
            }
        }, to: encodedURL!,usingThreshold: UInt64.init(),method: .post, headers: headers).uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in }).response { (response) in
            self.delegate?.killLoading()
            switch response.result {
            case .success(let resut):
                let json = JSON(resut!)
                print(json)
                if json["success"] == false {
                }else {
                    let jsonData = Data("\(json)".utf8)
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(EventsResponse.self, from: jsonData)
                        print(data)
                        if page == 1{
                            self.eventsArray = data.data?.data
                        }else{
                            self.eventsArray?.append(contentsOf: data.data?.data ?? [])
                        }
                        self.eventsBookmarkArry = []
                        for post in self.eventsArray ?? [] {
                            self.eventsBookmarkArry.append(post?.bookmark ?? false)
                        }
                        self.lastPageForEvents = data.data?.meta?.lastPage ?? 1
                        self.outputDelegate?.reloadEventsData()
                        
                        self.eventsIsPagination = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let err):
                print("error".localiz())
            }
        }
    }
    
    
    
    func callGetPollsApi(page:Int){
        pollsIsPagination = true
        self.delegate?.showLoading()
        var headers : HTTPHeaders = [:]
        
        if UserDefaults.standard.isLoggedIn() {
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":UserData.shared.token!]
        }else{
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":""]
        }
        let Url = "\(Environment.baseUrl)poll?page=\(page)"
        let encodedURL = Url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        AF.upload(multipartFormData: { (multipartFormData) in
          
        let deviceId = UserData.shared.deviceId ?? ""
            if !UserDefaults.standard.isLoggedIn() {
                multipartFormData.append((deviceId.data(using: String.Encoding.utf8)!), withName: "device_id")
            }
        }, to: encodedURL!,usingThreshold: UInt64.init(),method: .post, headers: headers).uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in  }).response { (response) in
            self.delegate?.killLoading()
            switch response.result {
            case .success(let resut):
                let json = JSON(resut!)
                print(json)
                if json["success"] == false {
                }else {
                    let jsonData = Data("\(json)".utf8)
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(PollResponse.self, from: jsonData)
                        print(data)
                        if page == 1{
                            self.pollsArray = data.data?.data
                        }else{
                            self.pollsArray?.append(contentsOf: data.data?.data ?? [])
                        }
                        self.pollsBookmarkArry = []
                        for poll in self.pollsArray ?? [] {
                            self.pollsBookmarkArry.append(poll?.bookmark ?? false)
                        }
                        self.lastPageForPolls = data.data?.meta?.lastPage ?? 1
                        self.outputDelegate?.reloadPollsData()
                        self.pollsIsPagination = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let err):
                print("error".localiz())
            }
        }
    }
    
   
    
}

