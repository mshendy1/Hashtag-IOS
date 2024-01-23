//
//  MyEventsViewModel+Delegates.swift
//  HashTag
//
//  Created by Eman Gaber on 27/02/2023.
//

import Foundation
import UIKit

extension MyEventsVC:MyEventsViewModelDelegates{

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
    
    func createEventTapped() {
        let vc = CreateEventVC()
        vc.fromMyEvents = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func getEvents(recent: [Events?]?, complete: [Events?]?) {
        if recent?.count == 0 && complete?.count == 0 {
            addEventView.isHidden = true
            table.setEmptyView(title:"", message: Constants.messages.emptyMyRecentEvente)
        }else{
            table.restore()
            addEventView.isHidden = false
        }
            table.reloadData()
    }
}


