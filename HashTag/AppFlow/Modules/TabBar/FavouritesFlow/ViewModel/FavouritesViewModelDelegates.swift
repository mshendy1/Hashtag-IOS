//
//  FavouritesViewModelDelegates.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.
//

import Foundation
import UIKit
extension FavouritesVC:FavouritesViewModelDelegates,LoginAlertViewModelDelegates{
    func openAppStore(){}
    
    func checkIfUserLoggedIn() {}
    
    func LoginActionSuccess() {
        FavouritsVM?.delegate?.moveToLogin()
    }
    
    func logoutActionSuccess(){}    
    
    func moveToLogin(){
        let vc = LoginVC()
        General.sharedInstance.mainNav!.pushViewController(vc, animated: true)
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

    
    func getFavPosts(model: [FavPostsModel?]?) {
        if model?.count == 0 {
            table.setEmptyView(title: "", message: Constants.messages.msgEmptyFavPosts)
        }else{
            table.restore()
        }
        table.reloadData()
    }
    
    func getFavEvents(model: [EventModel?]?) {
        
        if model?.count == 0 {
            table.setEmptyView(title: "", message: Constants.messages.msgEmptyFavEvents)
        }else{
            table.restore()
        }
        table.reloadData()
    }
    
    func getFavPolls(model: [PollModel?]?) {
        
        if model?.count == 0 {
            table.setEmptyView(title: "", message: Constants.messages.msgEmptyFavPolls)
        }else{
            table.restore()
            
        }
        table.reloadData()
    }
    
    func newsTapped() {
        selectButton(button: btnNews)
        unselectButton(button: btnEvents)
        unselectButton(button: btnSurveys)
        table.reloadData()
        //  handelTableHeight()
    }
    func surveysTapped() {
        selectButton(button: btnSurveys)
        unselectButton(button: btnEvents)
        unselectButton(button: btnNews)
        
        table.reloadData()
        //handelTableHeight()
    }
    func eventsTapped() {
        selectButton(button: btnEvents)
        unselectButton(button: btnNews)
        unselectButton(button: btnSurveys)
        
        table.reloadData()
        // handelTableHeight()
    }
    

    
    func selectButton(button:UIButton){
        button.backgroundColor = Colors.selectedBtnColor
        button.setTitleColor(Colors.PrimaryColor, for: .normal)
    }
    
    func unselectButton(button:UIButton){
        button.setTitleColor(Colors.textColor, for: .normal)
        button.backgroundColor = .white
    }
    
    func addToFavSuccessfully(index:Int,type:Types){
        switch type {
        case .news:
            let bookMark = FavouritsVM?.postsArray![index]!.bookmark
            FavouritsVM?.postsArray![index]?.bookmark = !bookMark!
            if !UserDefaults.standard.isLoggedIn(){
                FavouritsVM?.callGetFavPostsApi(deviceId:uuid ?? "")
            }else{
                FavouritsVM?.callGetFavPostsApi(deviceId:"")
            }
          //  table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
            table.reloadData()
        case .surveys:
            let bookMark = FavouritsVM?.pollsArray![index]!.bookmark
            FavouritsVM?.pollsArray![index]?.bookmark = !bookMark!
            if !UserDefaults.standard.isLoggedIn(){
                FavouritsVM?.callGeFavPollsApi(deviceId:uuid ?? "")
            }else{
                FavouritsVM?.callGeFavPollsApi(deviceId:"")
            }
          //  table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
            table.reloadData()
        case .events:
                let bookMark = FavouritsVM?.eventsArray![index]!.bookmark
            FavouritsVM?.eventsArray![index]?.bookmark = !bookMark!
            if !UserDefaults.standard.isLoggedIn(){
                FavouritsVM?.callGetFavEventsApi(deviceId:uuid ?? "")
            }else{
                FavouritsVM?.callGetFavEventsApi(deviceId:"")
            }
         //   table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
            table.reloadData()
        }
        
    }
    
    
    func likePostSuccessfully(index:Int) {
        if FavouritsVM?.postsArray?[index]?.like == true{
            FavouritsVM?.postsArray?[index]?.likeCount -= 1
            FavouritsVM?.postsArray?[index]?.like = false
        }else
        {
            FavouritsVM?.postsArray?[index]?.likeCount += 1
            FavouritsVM?.postsArray?[index]?.like = true
        }
        table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
       
        print("like added")
    }
    
}

