//
//  FavouritesViewModel.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.
//

import Foundation
protocol SearchsOutPutViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func eventsTapped()
    func newsTapped()
    func surveysTapped()
    func moveToLogin()
    func addToFavSuccessfully(index:Int,type:Types)
    func likePostSuccessfully(index:Int)
    func getSearchPosts(model:[SearchPostModel?]?)
    func getSearchEvents(model:[SearchEventsModel?]?)
    func getSearchPolls(model:[SearchPollsModel?]?)
}

class SearchsOutPutViewModel {
    weak var delegate: SearchsOutPutViewModelDelegates?
   
    init(delegate:SearchsOutPutViewModelDelegates) {
        self.delegate = delegate
    }
    var SearchPostsArray: [SearchPostModel?]?
    var SearchEventssArr: [SearchEventsModel?]?
    var SearchpollsArray: [SearchPollsModel?]?
   
    func callSearchApi(keyWord:String,type:SearchTypes){
        self.delegate?.showLoading()
        FavouritesNetworkManager.getSearchApi(query:keyWord) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.SearchpollsArray = model?.data?.surveys?.data
                self.SearchEventssArr = model?.data?.events?.data
                self.SearchPostsArray = model?.data?.posts?.data
                if type == .events{
                    self.delegate?.getSearchEvents(model: self.SearchEventssArr ?? [])
                }
                else
                if type == .news{
                    self.delegate?.getSearchPosts(model: self.SearchPostsArray ?? [])
                }else{
                    self.delegate?.getSearchPolls(model: self.SearchpollsArray ?? [])
                }
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    
    func likePostApi(id:Int,index:Int,deviceId:String) {
        self.delegate?.showLoading()
        HomeNetWorkManager.likePostApi(id: id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.likePostSuccessfully(index:index)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    
    func addPostsToFavApi(id:Int,index: Int,deviceId:String) {
        self.delegate?.showLoading()
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
        self.delegate?.showLoading()
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
        self.delegate?.showLoading()
        HomeNetWorkManager.addFavEventApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully(index: index, type: .events)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
}
