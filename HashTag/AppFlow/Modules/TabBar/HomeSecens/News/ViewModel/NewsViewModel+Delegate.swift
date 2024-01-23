//
//  NewsViewModel+Delegate.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.

import Foundation
import UIKit
import LanguageManager_iOS
import DropDown
import ListPlaceholder

// MARK: - HomeViewModelDelegates --->
extension NewsVC:NewsViewModelDelegates{
    func showLoading(){
        startLoadingIndicator()
    }
    func killLoading(){
        stopLoadingIndicator()
    }
    func connectionFailed(){
        showNoInternetAlert()
    }
    func showError(error: String){
        showErrorNativeAlert(message: error)
    }
    func getEventsTypesSuccessfully(typesModel: [TypesModel]?){}
    func getCountriesSuccessfully(countriesModel:[CountriesModel?]?){}
    func createEventSuccessfully() {}
    func likePostSuccessfully(index:Int) {
        if newsVM?.postsArray?[index]?.like == true{
            newsVM?.postsArray?[index]?.likeCount -= 1
            newsVM?.postsArray?[index]?.like = false
        }else {
            newsVM?.postsArray?[index]?.likeCount += 1
            newsVM?.postsArray?[index]?.like = true
        }
        table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        print("like added")
    }
    func addToFavSuccessfully(index:Int){
            let bookMark = newsVM?.postsArray![index]!.bookmark
        newsVM?.postsArray![index]?.bookmark = !bookMark!
        newsVM?.postsBookmarkArry[index] = !bookMark!
        table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        }

    func moveToVideoDetails(id: Int,videoUrl: String?,video:String?) {
        let vc = PostDetailsVC()
        vc.postId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToPostDetails(id: Int) {
            let vc = PostDetailsVC()
            vc.postId = id
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func newsFilterTapped() {
        let vc = NewsFilterVC()
       vc.selectCategoryVM  = self.selectCategoryVM
       vc.modalPresentationStyle = .custom
       vc.transitioningDelegate = self
       self.present(vc, animated:true, completion: nil)
    }

    func reloadPosts(){
        if newsVM?.postsArray?.count == 0 {
            table.setEmptyView(title: "", message:Constants.messages.msgEmptyPostsList)
        }else{
            table.restore()
        }
            table.reloadData()
    }
    
    func pollDetails(id:Int){
        let vc = PollsDetailsVC()
        vc.surveyID = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

// MARK: - LoginAlertViewModelDelegates --->
extension NewsVC:LoginAlertViewModelDelegates{
        func openAppStore() {}
        func checkIfUserLoggedIn(){}
        func LoginActionSuccess() {moveToLogin()}
        func logoutActionSuccess() {}
        func moveToLogin(){
            let vc = LoginVC()
            General.sharedInstance.mainNav!.pushViewController(vc, animated: true)
        }
}

// MARK: - SelectCategoryViewModelDelegate --->
extension NewsVC:SelectCategoryViewModelDelegate{
    func getTagsSuccessfully(tags: [TagsModel]?) {}
    func addTagsSuccessfully() {}
    func addCategorySuccessfully() {}
    func getCategorySuccessfully(categories:[CategoryModel]?) {
        CategoriesCollection.reloadData()
    }
}
