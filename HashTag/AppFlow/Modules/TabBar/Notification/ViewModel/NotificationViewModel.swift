//
//  MyEventsViewModel.swift
//  HashTag
//
//  Created by Eman Gaber on 27/02/2023.
//

import Foundation
import Alamofire
import LanguageManager_iOS
import SwiftyJSON

protocol NotificationViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func getNotifications()
    func switchNotifications()
    func moveTo(type:String,id:Int)

}

class NotificationViewModel {
    weak var delegate: NotificationViewModelDelegates?
    
    init(delegate:NotificationViewModelDelegates) {
        self.delegate = delegate
    }
    
    var notificatiosArray: [Notifications]?
    var NotifisIsPagination = true
    var lastPageFor :Int?


    
    func switchNotificationsApi(id:Int, deviceId:String){
        self.delegate?.showLoading()
        NotificationNetworkigManager.switchNotificationsApi(id: id, device:deviceId){ (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.switchNotifications()
                
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    
    func callGetNotifications(page:Int){
        NotifisIsPagination = true
        self.delegate?.showLoading()
        var headers : HTTPHeaders = [:]
        
        if UserDefaults.standard.isLoggedIn() {
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":UserData.shared.token!]
        }else{
            headers = ["Accept-Language":LanguageManager.shared.isRightToLeft ? "ar":"en","Content-Type":"application/json","Request-Type":"iOS","Accept":"application/json","X-Authorization":""]
        }
        let Url = "\(Environment.baseUrl)notification?page=\(page)"
        let encodedURL = Url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        AF.upload(multipartFormData: { (multipartFormData) in
        }, to: encodedURL!,usingThreshold: UInt64.init(),method:.get, headers: headers).uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in }).response { (response) in
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
                        let data = try decoder.decode(NotificationResponse.self, from: jsonData)
                        print(data)
                        if page == 1
                        {
                            self.notificatiosArray = data.data?.data
                        }else
                        {
                            self.notificatiosArray?.append(contentsOf: data.data?.data ?? [])
                        }
                        self.lastPageFor = data.data?.meta?.lastPage ?? 1
                        self.delegate?.getNotifications()
                        self.NotifisIsPagination = false
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
