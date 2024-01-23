//
//  CreateEventViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 19/08/1444 AH.
//

import Foundation

import Foundation
import Alamofire
import LanguageManager_iOS
import SwiftyJSON
import UIKit

protocol CreateEventVMDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func createEventSuccessfully(msg:String)
    func getEventsTypesSuccessfully(typesModel:[TypesModel]?)
    func getCountriesSuccessfully(countriesModel:[CountriesModel?]?)
}

class CreateEventViewModel {
    weak var delegate: CreateEventVMDelegates?
    init(delegate:CreateEventVMDelegates) {
        self.delegate = delegate
    }
    
    var countriesArray: [CountriesModel?]?
    var eventsTypesArray: [TypesModel]?

    
    func createEventApi(parameters: [String : Any],image:UIImage?,video:URL?){
        self.delegate?.showLoading()
        HomeNetWorkManager.createEventAPI(eventImage: image, eventVideo: video, params:parameters) { (result,message)  in
            self.delegate?.killLoading()
            if result?.status != false{
            self.delegate?.createEventSuccessfully(msg: result?.message ?? "")
            }else{
            self.delegate?.showError(error: result?.message ?? "")
            }
        }
    }


    func callGetTypessApi() {
        self.delegate?.showLoading()
        HomeNetWorkManager.getEventsTypesApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.eventsTypesArray = model?.data
                self.delegate?.getEventsTypesSuccessfully(typesModel: self.eventsTypesArray ?? [])
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func callGetCountriesApi() {
        self.delegate?.showLoading()
        HomeNetWorkManager.getCountriesApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.countriesArray = model?.data?.data
                self.delegate?.getCountriesSuccessfully(countriesModel: self.countriesArray ?? [])
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
   
}
