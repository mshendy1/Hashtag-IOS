//
//  MyEventsViewModel+Delegates.swift
//  HashTag
//
//  Created by Eman Gaber on 27/02/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS
import ListPlaceholder

extension NotificationVC:NotificationViewModelDelegates{
    func switchNotifications(){
        if UserDefaults.standard.isNotification(){
            header?.switchNotificattion?.isOn = false
            UserDefaults.standard.setNotifiaction(value:false)
            
        }else{
            header?.switchNotificattion?.isOn = true
            UserDefaults.standard.setNotifiaction(value: true)
        }
    }
    
    
    func getNotifications() {
        if NotificationVM?.notificatiosArray?.count == 0 ||  NotificationVM?.notificatiosArray?.count == nil{
            table.setEmptyView(title: "", message:Constants.messages.msgNoNotificationsFound)
        }else{
            table.restore()
        }
        DispatchQueue.main.async{
            self.table.reloadData()
        }
            self.table.showLoader()
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
            
    }
    

   @objc func removeLoader(){
    self.table.hideLoader()
   }

    func showLoading() {
        startLoadingIndicator()
    }
    
    func killLoading() {
        stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
      //  NetworkMonitor.shared.startMonitoring()
    }
    
    func showError(error: String){
        showErrorNativeAlert(message: error)
    }

    func moveTo(type:String,id:Int){
        if type == "news"{
            let vc =  PostDetailsVC()
            vc.postId = id
            self.navigationController?.pushViewController(vc, animated: true)
        }else if type == "event"{
            let vc = EventsDetailsVC()
            vc.eventId = id
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = PollsDetailsVC()
            vc.surveyID = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}


