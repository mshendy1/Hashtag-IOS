//
//  PollsViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation
import Alamofire
import LanguageManager_iOS
import SwiftyJSON
import UIKit


 protocol PollsViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func reloadPollsData()
    func moveToPollDetails(id: Int)
    func addToFavSuccessfully(index:Int,type:Types)
}

class PollsViewModel {
    weak var delegate: PollsViewModelDelegates?
    init(delegate:PollsViewModelDelegates) {
        self.delegate = delegate
    }
    
    var pollsIsPagination = false
    var pollsArray: [PollModel?]?
    var pollsBookmarkArry :[Bool] = []
    var lastPageForPolls :Int?
    
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
                        self.delegate?.reloadPollsData()
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
    
}

