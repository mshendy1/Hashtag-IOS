//
//  CommonQeusVM.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import Foundation
protocol CommonQeusVMDelegates: AnyObject {
    func showLoading()
    func killLoading()
    func connectionFailed()
    func showError(error:String)
    func getCommomQuesSuccessfully(model:[QuesModel]?)
       

}

class CommonQeusVM {
    weak var delegate: CommonQeusVMDelegates?
    
    init(delegate:CommonQeusVMDelegates) {
        self.delegate = delegate
    }
    
    var quesArray:[QuesModel]?
    func getCommonQuesAPI(){
            self.delegate?.showLoading()
        SettingsNetworkManager.getCommonQuesApi{ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    quesArray = model?.data?.data
                    self.delegate?.getCommomQuesSuccessfully(model: quesArray ?? [])
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }
}
