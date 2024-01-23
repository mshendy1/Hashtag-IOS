//
//  NewsViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation
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


 protocol NewsViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func reloadPosts()
    func newsFilterTapped() 
    func likePostSuccessfully(index:Int)
    func addToFavSuccessfully(index:Int)
    func moveToPostDetails(id:Int)
    func moveToVideoDetails(id: Int,videoUrl: String?,video:String?)
}

class NewsViewModel {
    weak var delegate: NewsViewModelDelegates?
    init(delegate:NewsViewModelDelegates) {
        self.delegate = delegate
    }
    
    var filterArray:[EventModel?]?
    var postsArray: [NewsPostsModel?]?
    var lastPageForPosts :Int?
    var postsIsPagination = false
    var postsBookmarkArry :[Bool] = []
    
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
                self.delegate?.addToFavSuccessfully(index: index)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
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
                        self.delegate?.reloadPosts()
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
    
}

