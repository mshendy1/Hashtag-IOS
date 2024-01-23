

import Foundation
//
//  TrendsViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 22/07/1444 AH.
//

import Foundation
import Alamofire
import LanguageManager_iOS
import SwiftyJSON
import UIKit


 protocol TrendsViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func youtubeTapped(url:String)
    func trendGoogleNewsTapped(url:String)
    func trendGoogleTapped(url:String)
    func trendTwitterTapped(tex:String)
    func getTwitterTrendSuccessfully(model:[TrendTwitterModel?]?)
    func reloadTableAndCollection()
}

class TrendsViewModel {
    weak var delegate: TrendsViewModelDelegates?
    init(delegate:TrendsViewModelDelegates) {
        self.delegate = delegate
    }

    var trendYoutubeArray: [TrendYoutubeModel?]?
    var trendGoogleArray: [TrendGoogleModel?]?
    var trendTwitterArray: [TrendTwitterModel?]?
    var trendGoogleNewsArray: [TrendGoogleNewsModel?]?
    
    func callGetTrendsYoutubeApi(){
        self.delegate?.showLoading()
        HomeNetWorkManager.getTrendsYoutubeApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.trendYoutubeArray = model?.data
                self.delegate?.reloadTableAndCollection()
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func callGetTrendsTwitterApi(){
        self.delegate?.showLoading()
        HomeNetWorkManager.getTrendsTwitterApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.trendTwitterArray = model?.data
                self.delegate?.getTwitterTrendSuccessfully(model:self.trendTwitterArray ?? [])
                self.delegate?.reloadTableAndCollection()
            }else if (error != nil) {
                   self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func callGetTrendsGoogleApi(){
        self.delegate?.showLoading()
        HomeNetWorkManager.getTrendsGoogleApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.trendGoogleArray = model?.data
                self.delegate?.reloadTableAndCollection()
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func callGetTrendsNewsApi() {
        self.delegate?.showLoading()
        HomeNetWorkManager.getTrendsNewsApi() { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.trendGoogleNewsArray = model?.data
                self.delegate?.reloadTableAndCollection()
            }else if (error != nil)
            {
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
}

