//
//  SelectCategoryVMDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS

extension SelectCategoriesVC:SelectCategoryViewModelDelegate{
    func showLoading() {
        startLoadingIndicator()
    }
    
    func killLoading() {
        stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
        
    }
    
    func showError(error:String){
        showErrorNativeAlert(message: error)
    }
    
    func addCategorySuccessfully() {
        self.showSuccessAlertNativeAlert(message: Constants.messages.catAddedSucc)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute:{
            self.moveToHome()
        })

    }
    func addTagsSuccessfully() {}

    
    func getCategorySuccessfully(categories:[CategoryModel]?) {
        self.categories = categories
        selectionArray = []
        for _ in self.categories ?? []{
            selectionArray.append(false)
        }
          setupCollection()
        categoriesCollection.reloadData()
    }
    
    func getTagsSuccessfully(tags: [TagsModel]?) {}
    
    func moveToHome(){
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SSCustomTabBarViewController") as! SSCustomTabBarViewController

        let customTabBar = vc.tabBar as? SSCustomTabBar
        customTabBar?.customeLayout()
        
        if LanguageManager.shared.isRightToLeft
        {
            vc.lang = "ar"
        }
        General.sharedInstance.mainNav = self.navigationController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
