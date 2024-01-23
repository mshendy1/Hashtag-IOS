//
//  AddToFavourites.swift
//  HashTag
//
//  Created by Trend-HuB on 09/08/1444 AH.
//

import Foundation
protocol AddToFavouritesViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func addToFavSuccessfully(id:Int,type:Types)
    }

class AddToFavouritesViewModel {
    weak var delegate: AddToFavouritesViewModelDelegates?
    
    init(delegate:AddToFavouritesViewModelDelegates) {
        self.delegate = delegate
    }
    
    func addPostsToFavApi(id:Int,deviceId:String,type:Types) {
        self.delegate?.showLoading()
        HomeNetWorkManager.addFavPostApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully(id: id, type: .news)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    func addPollsToFavApi(id:Int,deviceId:String,type:Types) {
        self.delegate?.showLoading()
        HomeNetWorkManager.addFavPollApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully(id: id, type: .surveys)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func addEventToFavApi(id:Int,deviceId:String,type:Types) {
        self.delegate?.showLoading()
        HomeNetWorkManager.addFavEventApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully(id: id, type: .events)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
}
