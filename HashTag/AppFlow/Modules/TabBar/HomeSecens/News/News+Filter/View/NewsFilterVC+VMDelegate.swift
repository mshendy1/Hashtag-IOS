//
//  FilterVC+VMDelegate.swift
//  HashTag
//
//  Created by Eman Gaber on 21/02/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS

extension NewsFilterVC:SelectCategoryViewModelDelegate{
 
    
    func showLoading() {
        startLoadingIndicator()
    }
    
    func killLoading(){
        stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
        
    }
    
    func showError(error:String) {
        showErrorNativeAlert(message: error)
    }
    
    func addCategorySuccessfully() {
        showSuccessAlertNativeAlert(message:Constants.messages.catAddedSucc)

    }
    func addTagsSuccessfully(){
        showSuccessAlertNativeAlert(message:Constants.messages.tagsAddedSucc)
    }
    
    func getCategorySuccessfully(categories:[CategoryModel]?) {
        self.categories = categories
        selectionCatArray = []
        for _ in self.categories ?? []{
            selectionCatArray.append(false)
        }
          setupCategoryCollection()
        categoriesCollection.reloadData()
    }
    
    func getTagsSuccessfully(tags: [TagsModel]?) {
        self.tags = tags
        selectionTagsArray = []
        for _ in self.tags ?? []{
            selectionTagsArray.append(false)
        }
          setupTagsCollection()
        tagsCollection.reloadData()
    }
    
    
}
