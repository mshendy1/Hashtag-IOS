//
//  PollsDetailsViewModel.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import Foundation
protocol PollsDetailsViewModelDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func PollTapped()
    func moveToLogin()
    func moveToLoginSheetVC()
    func getSurvaySuccessfully(survey:PollsDetailsModel?)
    func addToFavSuccessfully()
    func addPollItemsSuccessfully(survey:PollsDetailsModel?)

}

class PollsDetailsViewModel {
    weak var delegate: PollsDetailsViewModelDelegates?
    init(delegate:PollsDetailsViewModelDelegates) {
        self.delegate = delegate
    }
    var surveyDetails:PollsDetailsModel?
    var pollImgsArray:[String]?

    func addPollItemApi(id:Int,surveyId:Int,device:String){
        self.delegate?.showLoading()
        HomeNetWorkManager.sendPollAPI(id:id,surveyID:surveyId,device:"ios" ){(model, error) in
            self.delegate?.killLoading()
            DispatchQueue.main.async {
                if (model != nil) {
//                    self.delegate?.getSurvaySuccessfully(survey:self.surveyDetails)
                    if !UserDefaults.standard.isLoggedIn(){
                        self.showPolldetailsAPI(surveyID: surveyId, deviceId: UserData.shared.deviceId ?? "")
                    }else{
                        self.showPolldetailsAPI(surveyID: surveyId, deviceId:"")
                    }
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    func showPolldetailsAPI(surveyID:Int,deviceId:String){
        self.delegate?.showLoading()
        HomeNetWorkManager.showPolldetailsAPI(surveyID: surveyID, deviceId: deviceId) { (model, error) in
            self.delegate?.killLoading()
            DispatchQueue.main.async {
                if (model != nil) {
                    self.surveyDetails = model?.data
                    print(self.surveyDetails)
                    self.pollImgsArray = self.surveyDetails?.images
                    self.delegate?.getSurvaySuccessfully(survey: model?.data)
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }

            }
        }
    }
    
    func addEventToFavApi(id:Int,deviceId:String) {
       self.delegate?.showLoading()
        HomeNetWorkManager.addFavPollApi(id:id,deviceId:deviceId) { (model, error) in
            self.delegate?.killLoading()
            if (model != nil) {
                self.delegate?.addToFavSuccessfully()
            }else if (error != nil){
                self.delegate?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
}
