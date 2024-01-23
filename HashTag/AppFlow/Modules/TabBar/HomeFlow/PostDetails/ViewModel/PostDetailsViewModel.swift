//
//  PostDetailsViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 01/08/1444 AH.
//

import Foundation
protocol PostDetailsViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func moveToLogin()
    func showError(error:String)
    func getPostDetailsSuccessfully(model:PostDetailsData?)
    func getCommentsSuccessfully(model:[CommentsModel]?)
    func getTagsSuccessfully(model:[TagModel]?)
    func addCommentSuccessfully()
    func likePostSuccessfully(id:Int)
    func addToFavSuccessfully()

    }

class PostDetailsViewModel {
        weak var delegate: PostDetailsViewModelDelegates?
       
        init(delegate:PostDetailsViewModelDelegates) {
            self.delegate = delegate
        }
    var postDetails: PostDetailsData?
    var commentsArray:[CommentsModel]?
    var tagsArray:[TagModel]?
    var postImgsArray:[String]?
   
    func callGetPostDetailsApi(postId:Int,deviceId:String){
            self.delegate?.showLoading()
        HomeNetWorkManager.getPostDetailsApi(id:postId, deviceId: deviceId) { [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    self.postDetails = model?.data
                    self.commentsArray = model?.data?.comments
                    self.tagsArray = model?.data?.tags
                    DispatchQueue.main.async { [self] in
                        self.delegate?.getPostDetailsSuccessfully(model:postDetails)
                        self.delegate?.getCommentsSuccessfully(model: self.commentsArray ?? [])
                        self.postImgsArray = self.postDetails?.gallery
                        self.delegate?.getTagsSuccessfully(model: tagsArray ?? [])
                    }
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
    
    func addCommentApi(comment:String,postId:Int){
            self.delegate?.showLoading()
            HomeNetWorkManager.addCommentApi(comment:comment,postId:postId){ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    self.delegate?.addCommentSuccessfully()
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
    
    
    func likePostApi(id:Int,deviceId:String) {
        self.delegate?.showLoading()
        HomeNetWorkManager.likePostApi(id: id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.likePostSuccessfully(id:id)
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func addEventToFavApi(id:Int,deviceId:String) {
        //self.delegate?.showLoading()
        HomeNetWorkManager.addFavPostApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully()
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    
}
