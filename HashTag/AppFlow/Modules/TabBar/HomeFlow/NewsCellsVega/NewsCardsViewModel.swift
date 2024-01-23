//
//  NewsCardsViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 02/12/1444 AH.
//

import Foundation
import Alamofire
import LanguageManager_iOS
import SwiftyJSON

protocol NewsCardsViewModelDelegate:AnyObject{
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func reloadPosts()
}

class NewsCardsViewModel {
    weak var delegate: NewsCardsViewModelDelegate?
    
    init(delegate:NewsCardsViewModelDelegate) {
        self.delegate = delegate
    }
    var postsIsPagination = false
    var lastPageForPosts :Int?
    var postsArray: [NewsPostsModel?]?
    var postsBookmarkArry :[Bool] = []

    
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
                        if page == 1
                        {
                            self.postsArray = data.data?.data
                        }else
                        {
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
