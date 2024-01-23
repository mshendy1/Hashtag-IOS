//
//  MyEventsViewModel.swift
//  HashTag
//
//  Created by Eman Gaber on 27/02/2023.
//

import Foundation

protocol MyEventsViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func createEventTapped()
    func getEvents(recent:[Events?]?,complete:[Events?]?)
}

class MyEventsViewModel {
    weak var delegate: MyEventsViewModelDelegates?
    
    init(delegate:MyEventsViewModelDelegates) {
        self.delegate = delegate
    }
    
    var recentEventsArray: [Events?]?
    var completedEventsArray: [Events?]?
    
    func callGetMyEventsApi(){
        self.delegate?.showLoading()
        SettingsNetworkManager.getMyEventsApi{ (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.recentEventsArray = model?.data?.data?.eventRecent?.data
                self.completedEventsArray = model?.data?.data?.eventCompleted?.data
                self.delegate?.getEvents(recent: self.recentEventsArray ?? [], complete: self.completedEventsArray ?? [])
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
}
