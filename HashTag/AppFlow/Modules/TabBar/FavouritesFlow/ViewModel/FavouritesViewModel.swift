//
//  FavouritesViewModel.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.
//

import Foundation
import Foundation
protocol FavouritesViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func eventsTapped()
    func newsTapped()
    func moveToLogin()
    func surveysTapped()
    func likePostSuccessfully(index:Int)
    func getFavPosts(model:[FavPostsModel?]?)
    func getFavEvents(model:[EventModel?]?)
    func getFavPolls(model:[PollModel?]?)
    func addToFavSuccessfully(index:Int,type:Types)
}

class FavouritesViewModel {
    weak var delegate: FavouritesViewModelDelegates?
   
    init(delegate:FavouritesViewModelDelegates) {
        self.delegate = delegate
    }
    
    var eventsArray: [EventModel?]?
    var postsArray: [FavPostsModel?]?
    var pollsArray: [PollModel?]?

    func callGetFavEventsApi(deviceId:String){
        self.delegate?.showLoading()
        FavouritesNetworkManager.getFavEventsApi(deviceId:deviceId){(model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.eventsArray = model?.data?.data
                self.delegate?.getFavEvents(model: self.eventsArray ?? [])

            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }

    func callGeFavPollsApi(deviceId:String) {
        self.delegate?.showLoading()
        FavouritesNetworkManager.getFavPollsApi(deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.pollsArray = model?.data?.data
                self.delegate?.getFavPolls(model: self.pollsArray ?? [])
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }

    func callGetFavPostsApi(deviceId:String){
        self.delegate?.showLoading()
        FavouritesNetworkManager.getFavPostsApi(deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.postsArray = model?.data?.data
                self.delegate?.getFavPosts(model: self.postsArray ?? [])
                self.delegate?.newsTapped()
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func addPostsToFavApi(id:Int,deviceId:String,index: Int) {
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
    func addPollsToFavApi(id:Int,deviceId:String,index: Int) {
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
    
    func addEventToFavApi(id:Int,deviceId:String,index: Int) {
        //self.delegate?.showLoading()
        HomeNetWorkManager.addFavEventApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully(index: index, type:.events)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    func likePostApi(id:Int,index:Int,deviceId:String) {
        self.delegate?.showLoading()
        HomeNetWorkManager.likePostApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.likePostSuccessfully(index:index)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }

    

}
