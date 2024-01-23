//
//  EventsViewModel+Delegates.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation

extension EventsVC:EventsViewModelDelegates{
    func showLoading(){
        startLoadingIndicator()
    }
    func killLoading(){
        stopLoadingIndicator()
    }
    func connectionFailed(){
        showNoInternetAlert()
    }
    func showError(error: String){
        showErrorNativeAlert(message: error)
    }
    
    func getEventsTypesSuccessfully(typesModel: [TypesModel]?){}
    func getCountriesSuccessfully(countriesModel:[CountriesModel?]?){}
   
    func addToFavSuccessfully(index: Int, type: Types) {
            if isFilter == true {
                let bookMark = eventVM?.filterArray![index]!.bookmark
                eventVM?.filterArray![index]?.bookmark = !bookMark!
            }else{
                let bookMark = eventVM?.eventsArray![index]!.bookmark
                eventVM?.eventsArray![index]?.bookmark = !bookMark!
            }
            table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
    }
    
    func createEventTapped() {
        let vc = CreateEventVC()
        vc.fromMyEvents = true
        vc.eventVM = eventVM
//        vc.selectCategoryVM = selectCategoryVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func eventsFilterTapped() {
        let vc = EventsFilterVC()
        vc.eventVM  = self.eventVM
        vc.selectCategoryVM = self.selectCategoryVM
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated:true, completion: nil)
    }
    
    func moveToEventDetails(id: Int) {
        let vc = EventsDetailsVC()
        vc.eventId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadEventsData() {
        if eventVM?.eventsArray?.count == 0 ||  eventVM?.eventsArray?.count == nil{
            showErrorNativeAlert(message: Constants.messages.msgEmptyEventsList)
         
        }else{
            table.reloadData()
        }
        
    }
    
    func getEventsSuccessfully(event:[EventModel?]?){
        if event?.count == 0 || event?.count == nil {
        table.setEmptyView(title: "", message: Constants.messages.msgnoDataFound)
        }else{
            table.restore()
        }
            table.reloadData()
            calendar.reloadData()
    }
    
    func getFilterEventsSuccessfully(event:[EventModel?]?){
        if event?.count == 0 || event?.count == nil {
            table.setEmptyView(title: "", message: Constants.messages.msgnoDataFound)
        }else{
            table.restore()
        }
            table.reloadData()
    }
    
}
