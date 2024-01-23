//
//  EventDetailsViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 24/07/1444 AH.
//

import Foundation

protocol EventDetailsViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func moveToLogin()
    func getEventDetailsSuccessfully(model:EventDetailsModel?)
    func addToFavSuccessfully()
    }

class EventDetailsViewModel {
        weak var delegate: EventDetailsViewModelDelegates?
       
        init(delegate:EventDetailsViewModelDelegates) {
            self.delegate = delegate
        }
        
    var eventDetails: EventDetailsModel?
    func callGetEventDetailsApi(evetId:Int,deviceId:String){
            self.delegate?.showLoading()
        HomeNetWorkManager.getEventDetailsApi(id:evetId, deviceId: deviceId) { [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                  self.eventDetails = model?.data
                    self.delegate?.getEventDetailsSuccessfully(model: eventDetails)
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }

    
    func addEventToFavApi(id:Int,deviceId:String) {
        //self.delegate?.showLoading()
        HomeNetWorkManager.addFavEventApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully()
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
}
