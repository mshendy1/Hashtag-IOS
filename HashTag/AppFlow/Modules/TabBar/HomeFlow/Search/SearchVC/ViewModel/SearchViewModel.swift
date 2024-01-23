//
//  SearchViewModel.swift
//  E-CommerceApp
//
//  Created by Eman Gaber on 27/07/2022.
//

import Foundation
import UIKit

 protocol SearchViewModelDelegate: AnyObject {
    func showLoading()
    func killLoading()
     func showError(error:String)
    func connectionFailed()
    func getSearchItemsSuccessfully()
}

class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
    init(delegate:SearchViewModelDelegate?) {
        self.delegate = delegate
    }

    
    var searchItemsArr:[String]?
    
    func getSearchItemsAPI(name:String){
            self.delegate?.showLoading()
        HomeNetWorkManager.searchResultApi(text:name){ [self] (model, error) in
                self.delegate?.killLoading()
                if (model != nil) {
                    searchItemsArr = model?.data
                    
                    delegate?.getSearchItemsSuccessfully()
                }else if (error != nil){
                    self.delegate?.showError(error: error?.localizedDescription ?? "")
                }
            }
        }

}
