//
//  CreateEventVM+Delegate.swift
//  HashTag
//
//  Created by Trend-HuB on 19/08/1444 AH.
//

import Foundation

extension CreateEventVC:CreateEventVMDelegates{
    func getCountriesSuccessfully(countriesModel:[CountriesModel?]?){
        setupCountriesMenu()
    }
    
    func getEventsTypesSuccessfully(typesModel: [TypesModel]?) {
        self.types = typesModel
        selectionTypesArray = []
        for _ in self.types ?? []{
            selectionTypesArray.append(false)
        }
        setupCollection()
        collection.reloadData()
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
    
    func createEventSuccessfully(msg:String) {
        self.showSuccessAlertNativeAlert(message:msg)
        if fromMyEvents == true{
            self.navigationController?.popViewController(animated:true)
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute:{
                self.moveToMyEvents()
            })
        }
        
     
    }
    
    func moveToMyEvents(){
        let vc = MyEventsVC()
        vc.fromHome = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


extension CreateEventVC:SelectCategoryViewModelDelegate{
    func getTagsSuccessfully(tags: [TagsModel]?) {
    }
    
    func addTagsSuccessfully() {
    }
    
    func addCategorySuccessfully() {}
    
    func getCategorySuccessfully(categories:[CategoryModel]?) {
       // loadCategoriesMenu(categories:categories)
    }
    
}
