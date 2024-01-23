//
//  SearchOutsVC.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.
//

import Foundation
import UIKit

extension SearchOutsVC:SearchsOutPutViewModelDelegates,LoginAlertViewModelDelegates{
    func openAppStore() {}
    
    func checkIfUserLoggedIn() {}
    
  
    func LoginActionSuccess() {
        searchOutsVM?.delegate?.moveToLogin()
    }
    
    func logoutActionSuccess() { }
    func moveToLogin(){
        let vc = LoginVC()
        General.sharedInstance.mainNav!.pushViewController(vc, animated: true)
    }

    func getSearchPosts(model: [SearchPostModel?]?) {
        if model?.count == 0 {
            table.setEmptyView(title: "", message: Constants.messages.msgEmptyPostsList)
        }else{
            table.restore()
        }
        table.reloadData()
    }
    
    func getSearchEvents(model: [SearchEventsModel?]?) {
        if model?.count == 0 {
            table.setEmptyView(title: "", message:Constants.messages.msgEmptyEventsList)
        }else{
            
            table.restore()
        }
        table.reloadData()
    }
    
    func getSearchPolls(model: [SearchPollsModel?]?) {
        if model?.count == 0 {
            table.setEmptyView(title: "", message: Constants.messages.msgEmptyPollsList)
        }else{
            table.restore()
        }
        table.reloadData()
    }
    
    func showLoading() {
        startLoadingIndicator()
    }
    
    func killLoading() {
        stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func showError(error: String){
        showErrorNativeAlert(message: error)
    }

    func newsTapped() {
        selectButton(button: btnNews)
        unselectButton(button: btnEvents)
        unselectButton(button: btnSurveys)
        table.reloadData()
    }
    func surveysTapped() {
        selectButton(button: btnSurveys)
        unselectButton(button: btnEvents)
        unselectButton(button: btnNews)
        table.reloadData()
    }
    func eventsTapped() {
        selectButton(button: btnEvents)
        unselectButton(button: btnNews)
        unselectButton(button: btnSurveys)
        table.reloadData()
    }
    
    func selectButton(button:UIButton){
        button.backgroundColor = Colors.selectedBtnColor
        button.setTitleColor(Colors.PrimaryColor, for: .normal)
    }
    
    func unselectButton(button:UIButton){
        button.setTitleColor(Colors.textColor, for: .normal)
        button.backgroundColor = .white
    }
    
    func likePostSuccessfully(index:Int) {
        if searchOutsVM?.SearchPostsArray?[index]?.like == true{
            searchOutsVM?.SearchPostsArray?[index]?.likeCount -= 1
            searchOutsVM?.SearchPostsArray?[index]?.like = false
        }else
        {
            searchOutsVM?.SearchPostsArray?[index]?.likeCount += 1
            searchOutsVM?.SearchPostsArray?[index]?.like = true
        }
        table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
       
        print("like added")
    }
    
    func addToFavSuccessfully(index:Int,type:Types){
        switch type {
        case .news:
            let bookMark = searchOutsVM?.SearchPostsArray![index]!.bookmark
            searchOutsVM?.SearchPostsArray![index]?.bookmark = !bookMark!
            table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        case .surveys:
            let bookMark = searchOutsVM?.SearchpollsArray![index]!.bookmark
            searchOutsVM?.SearchpollsArray![index]?.bookmark = !bookMark!
            table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        case .events:
                let bookMark = searchOutsVM?.SearchEventssArr![index]!.bookmark
            searchOutsVM?.SearchEventssArr![index]?.bookmark = !bookMark!
            table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        }
    }
  
}

