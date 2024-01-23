//
//  EventsViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation
import Alamofire
import LanguageManager_iOS
import SwiftyJSON
import UIKit


protocol EventsViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func addToFavSuccessfully(index:Int,type:Types)
    func createEventTapped()
    func eventsFilterTapped()
    func moveToEventDetails(id:Int)
    func reloadEventsData()
    func getEventsTypesSuccessfully(typesModel:[TypesModel]?)
    func getEventsSuccessfully(event:[EventModel?]?)
    func getFilterEventsSuccessfully(event:[EventModel?]?)
    func getCountriesSuccessfully(countriesModel:[CountriesModel?]?)
}

class EventsViewModel {
    weak var delegate: EventsViewModelDelegates?
    init(delegate:EventsViewModelDelegates) {
        self.delegate = delegate
    }
    
    var eventsIsPagination = false
    var eventsTypesArray: [TypesModel]?
    var eventsArray: [EventModel?]?
    var filterArray:[EventModel?]?
    var eventsBookmarkArry :[Bool] = []
    var lastPageForEvents :Int?
    var countriesArray: [CountriesModel?]?

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
    
    func callGetEventsApi(category_id: [Int],city_id:[Int],page:Int){
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
            var categoryIdstr = ""
            for id in category_id {
                categoryIdstr.append("\(id)")
                categoryIdstr.append(",")
            }
            
            if categoryIdstr.count > 0 {
                categoryIdstr.removeLast()
                multipartFormData.append(categoryIdstr.data(using: String.Encoding.utf8)!, withName: "category_id[]")
            }
            var cityIdstr = ""
            for id in category_id {
                cityIdstr.append("\(id)")
                cityIdstr.append(",")
            }
            
            if cityIdstr.count > 0 {
                cityIdstr.removeLast()
                multipartFormData.append(cityIdstr.data(using: String.Encoding.utf8)!, withName: "city_id[]")
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
                        self.delegate?.reloadEventsData()
                        
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
}

