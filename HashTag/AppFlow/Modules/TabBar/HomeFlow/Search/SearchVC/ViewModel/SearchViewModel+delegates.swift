//
//  SearchViewModel+delegates.swift
//  E-CommerceApp
//
//  Created by Eman Gaber on 27/07/2022.
//

import Foundation

extension SearchVC :SearchViewModelDelegate {

    func getSearchItemsSuccessfully() {
        if searchVM.searchItemsArr?.count == 0 {
            table.setEmptyView(title: "", message:Constants.messages.emptysearchTable)
        }else{
            
            table.restore()
            setupTableVC()
        }
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
}
