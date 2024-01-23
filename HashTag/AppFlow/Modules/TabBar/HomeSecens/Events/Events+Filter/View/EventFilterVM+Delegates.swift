//
//  EventFilterVM+Delegates.swift
//  HashTag
//
//  Created by Trend-HuB on 13/03/1445 AH.
//

import Foundation
extension EventsFilterVC:SelectCategoryViewModelDelegate,EventsViewModelDelegates{
    func showLoading() {
        startLoadingIndicator()
    }
    
    func killLoading(){
        stopLoadingIndicator()
    }
    
    func connectionFailed() {
        showNoInternetAlert()
        
    }
    func getTagsSuccessfully(tags: [TagsModel]?) {}
    func addToFavSuccessfully(index: Int, type: Types) {}
    func createEventTapped() {}
    func eventsFilterTapped() {}
    func moveToEventDetails(id: Int) {}
    func reloadEventsData() {}
    func getEventsTypesSuccessfully(typesModel: [TypesModel]?) {}
    func getEventsSuccessfully(event: [EventModel?]?) {}
    func getFilterEventsSuccessfully(event: [EventModel?]?){}

    
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
        categoriesCollection.reloadData()
    }
    func getCountriesSuccessfully(countriesModel: [CountriesModel?]?) {
        self.countries = eventVM?.countriesArray ?? []
        selectionCountriesArray = []
        for _ in self.countries ?? []{
            selectionCountriesArray.append(false)
        }
        countriesCollection.reloadData()
    }
        
}
