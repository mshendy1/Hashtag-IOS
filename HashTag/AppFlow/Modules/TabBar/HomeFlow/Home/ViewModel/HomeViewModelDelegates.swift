//
//  HomeViewModel+Delegate.swift
//  HashTag
//
//  Created by Trend-HuB on 22/07/1444 AH.
//

import Foundation
import UIKit
import LanguageManager_iOS
import DropDown
import ListPlaceholder

// MARK: - HomeViewModelDelegates --->
extension HomeVC:HomeViewModelDelegates{
    func showLoading() {startLoadingIndicator()}
    func killLoading() {stopLoadingIndicator()}
    func connectionFailed() {showNoInternetAlert()}
    func getEventsTypesSuccessfully(typesModel: [TypesModel]?){}
    func showError(error: String){showErrorNativeAlert(message: error)}
    func getCountriesSuccessfully(countriesModel:[CountriesModel?]?){}
    
    func getTwitterTrendSuccessfully(model: [TrendTwitterModel?]?) {
        if homeVM?.trendTwitterArray?.count == 0 || homeVM?.trendTwitterArray?.count == nil {
        table.setEmptyView(title: "", message:Constants.messages.msgnoDataFound)
         }else{
        table.restore()
       }
            table.reloadData()
    }
    
    func getEventsSuccessfully(event:[EventModel?]?){
        if event?.count == 0 || event?.count == nil {
        table.setEmptyView(title: "", message: Constants.messages.msgnoDataFound)
        }else{
            table.restore()
        }
            table.reloadData()
            handelTableHeight()
            calendar.reloadData()
    }
    
    
    func getFilterEventsSuccessfully(event:[EventModel?]?){
        if event?.count == 0 || event?.count == nil {
            table.setEmptyView(title: "", message: Constants.messages.msgnoDataFound)
        }else{
            table.restore()
        }
            table.reloadData()
            handelTableHeight()
    }
    

//MARK: - SET HOME VIEW UI --->
    func setLocalization(){
        if LanguageManager.shared.isRightToLeft{
            self.btnNews.setTitle(Constants.home.news, for: .normal)
            self.btnTrend.setTitle(Constants.home.trend, for: .normal)
            self.btnSurveys.setTitle(Constants.home.surveys, for: .normal)
            self.btnEvents.setTitle(Constants.home.events, for: .normal)
        }
    }
    
//MARK: - Calculate TableHeight --->
    func handelTableHeight() {
        switch self.selectedType{
        case .news:
            let videoArraycount = (homeVM?.postsArray?.filter({$0?.videoURL != "" || $0?.video != ""}).count) ?? 0
            let postsArraycount = homeVM?.postsArray?.filter({$0?.videoURL == ""}).count ?? 0
            tableHeight.constant = tableHeightOrgin
            viewHeight.constant = viewHeightOrgin
            let x = (Double(videoArraycount) * NewsVideoTablecellHeihht)
            let y = (Double(postsArraycount) * newsPostsTableCellHeight)
            
            let newHeight = CGFloat( x + y)
            tableHeight.constant = newHeight
            viewHeight.constant += (tableHeight.constant - tableHeightOrgin) - 200
            self.loadViewIfNeeded()
            
        case .surveys:
            tableHeight.constant = tableHeightOrgin
            viewHeight.constant = viewHeightOrgin
            let newHeight = CGFloat(homeVM?.pollsArray?.count ?? 0) * surveysTableCellHeight
            tableHeight.constant = newHeight 
            viewHeight.constant += (tableHeight.constant - tableHeightOrgin) - 200
            self.loadViewIfNeeded()
            
        case.events:
            tableHeight.constant = tableHeightOrgin
            viewHeight.constant = viewHeightOrgin
            let newHeight = CGFloat(homeVM?.eventsArray?.count ?? 0) * eventsTableCellHeight
            tableHeight.constant = newHeight
            viewHeight.constant += (tableHeight.constant - tableHeightOrgin) - 200
            self.loadViewIfNeeded()
            //trend
        case.youtube:
            tableHeight.constant = tableHeightOrgin
            viewHeight.constant = viewHeightOrgin
            let newHeight = CGFloat(homeVM?.trendYoutubeArray?.count ?? 0) * youtubeTableCellHeight
            tableHeight.constant = newHeight
            viewHeight.constant += (tableHeight.constant - tableHeightOrgin) - 200
            self.loadViewIfNeeded()
            
        case.googleNews:
            tableHeight.constant = tableHeightOrgin
            viewHeight.constant = viewHeightOrgin
            let newHeight = CGFloat(homeVM?.trendGoogleNewsArray?.count ?? 0) * googleNewsTableCellHeight
            tableHeight.constant = newHeight
            viewHeight.constant += (tableHeight.constant - tableHeightOrgin) - 200
            self.loadViewIfNeeded()
            
        case .twitter:
            tableHeight.constant = tableHeightOrgin
            viewHeight.constant = viewHeightOrgin
            let newHeight = CGFloat(homeVM?.trendTwitterArray?.count ?? 0) * twitterTableCellHeight
            tableHeight.constant = newHeight
            viewHeight.constant += (tableHeight.constant - tableHeightOrgin) - 200
            self.loadViewIfNeeded()
            
        case.google:
            tableHeight.constant = tableHeightOrgin
            viewHeight.constant = viewHeightOrgin
            let newHeight = CGFloat(homeVM?.trendGoogleArray?.count ?? 0) * twitterTableCellHeight
            tableHeight.constant = newHeight
            viewHeight.constant += (tableHeight.constant - tableHeightOrgin) - 200
            self.loadViewIfNeeded()
            
        case .none:
            break
        }
    }
    
    func selectButton(button:UIButton,underView:UIView){
        button.setTitleColor(Colors.PrimaryColor, for: .normal)
        underView.backgroundColor = Colors.PrimaryColor
    }
    
    func unselectButton(button:UIButton,underView:UIView){
        button.setTitleColor(Colors.textColor, for: .normal)
        underView.backgroundColor = .clear
    }
    
    func likePostSuccessfully(index:Int) {
        if homeVM?.postsArray?[index]?.like == true{
            homeVM?.postsArray?[index]?.likeCount -= 1
            homeVM?.postsArray?[index]?.like = false
        }else
        {
            homeVM?.postsArray?[index]?.likeCount += 1
            homeVM?.postsArray?[index]?.like = true
        }
        table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        print("like added")
    }
    
    
    func addToFavSuccessfully(index:Int,type:Types){
        switch type {
        case .news:
            let bookMark = homeVM?.postsArray![index]!.bookmark
            homeVM?.postsArray![index]?.bookmark = !bookMark!
            homeVM?.postsBookmarkArry[index] = !bookMark!
            table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        case .surveys:
            let bookMark = homeVM?.pollsArray![index]!.bookmark
            homeVM?.pollsArray![index]?.bookmark = !bookMark!
            table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        case .events:
            if isFilter == true {
                let bookMark = homeVM?.filterArray![index]!.bookmark
                homeVM?.filterArray![index]?.bookmark = !bookMark!
            }else{
                let bookMark = homeVM?.eventsArray![index]!.bookmark
                homeVM?.eventsArray![index]?.bookmark = !bookMark!
            }
            table.reloadRows(at: [IndexPath(row:index , section: 0)], with: .none)
        }
    }
}

//MARK: - HOME OUTPUTS DELEGATES --->
extension HomeVC:HomeOutputDelegate{
    func createEventTapped() {
        let vc = CreateEventVC()
       // vc.homeVM = homeVM
       // vc.selectCategoryVM = selectCategoryVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
       func newsTapped() {
           CalenderView.isHidden = true
           table.isHidden = false
           calenderStyle = false
           addEventView.isHidden = true
           
           self.CategorisView.isHidden = false
           self.categorizeStack.isHidden = true
           self.trendCollection.isHidden = true
           self.selectedType = .news
           
           selectButton(button: btnNews,underView: newsUnderView)
           unselectButton(button: btnTrend,underView:TrensUnderView)
           unselectButton(button: btnEvents,underView:eventsUnderView)
           unselectButton(button: btnSurveys,underView:pollsUnderView)
           
           if homeVM?.postsArray?.count == 0 {
               table.setEmptyView(title: "", message:Constants.messages.msgEmptyPostsList)
           }else{
               table.restore()
           }
               table.reloadData()
               handelTableHeight()
       }
    
    func trendTapped() {
        self.selectedType = .youtube //default
        CalenderView.isHidden = true
        table.isHidden = false
        calenderStyle = false
        addEventView.isHidden = true
        self.trendCollection.isHidden = false
        self.CategorisView.isHidden = true
        self.categorizeStack.isHidden = true
        
        selectButton(button: btnTrend,underView: TrensUnderView)
        unselectButton(button: btnNews,underView: newsUnderView)
        unselectButton(button: btnEvents,underView: eventsUnderView)
        unselectButton(button: btnSurveys,underView: pollsUnderView)
        handelTableHeight()
        trendCollection.reloadData()
        table.reloadData()
         
      }
    
    func surveysTapped(){
        CalenderView.isHidden = true
        table.isHidden = false
        calenderStyle = false
        addEventView.isHidden = true
        self.CategorisView.isHidden = true
        self.categorizeStack.isHidden = true
        self.trendCollection.isHidden = true
        self.selectedType = .surveys
       
        selectButton(button: btnSurveys,underView: pollsUnderView)
        unselectButton(button: btnNews,underView: newsUnderView)
        unselectButton(button: btnTrend,underView: TrensUnderView)
        unselectButton(button: btnEvents,underView: eventsUnderView)
        if homeVM?.pollsArray?.count == 0 ||  homeVM?.pollsArray?.count == nil{
            table.setEmptyView(title: "", message:Constants.messages.msgnoDataFound)
        }else{
            table.restore()
        }
            self.table.reloadData()
            self.handelTableHeight()
    }
    
    func eventTapped() {
        CalenderView.isHidden = true
        table.isHidden = false
        calenderStyle = false
        if !UserDefaults.standard.isLoggedIn(){
            addEventView.isHidden = true
        }else{
            addEventView.isHidden = false
        }
        self.categorizeStack.isHidden = false
        self.CategorisView.isHidden = true
        self.trendCollection.isHidden = true
        self.selectedType = .events
       
        unselectButton(button: btnNews,underView: newsUnderView)
        unselectButton(button: btnTrend,underView: TrensUnderView)
        selectButton(button: btnEvents,underView: eventsUnderView)
        unselectButton(button: btnSurveys,underView: pollsUnderView)
        
        if homeVM?.pollsArray?.count == 0 ||  homeVM?.pollsArray?.count == nil{
            table.setEmptyView(title: "", message:Constants.messages.msgnoDataFound)
        }else{
            table.restore()
        }
            table.reloadData()
            handelTableHeight()
    }
    func moveToVideoDetails(id: Int, videoUrl: String?,video:String?) {
        let vc = PostDetailsVC()
        vc.postId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToPostDetails(id: Int) {
            let vc = PostDetailsVC()
            vc.postId = id
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToPollDetails(id: Int) {
            let vc = PollsDetailsVC()
            vc.surveyID = id
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToEventDetails(id:Int) {
        let vc = EventsDetailsVC()
        vc.eventId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func newsFilterTapped() {
        let vc = NewsFilterVC()
       vc.selectCategoryVM  = self.selectCategoryVM
       vc.modalPresentationStyle = .custom
       vc.transitioningDelegate = self
       self.present(vc, animated:true, completion: nil)
    }
    func eventsFilterTapped() {
        let vc = EventsFilterVC()
       // vc.homeVM  = self.homeVM
        vc.selectCategoryVM = self.selectCategoryVM
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated:true, completion: nil)
    }

    
    func moveToSearch(){
        let vc = SearchVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func trendGoogleNewsTapped(url:String) {
        let vc = WebViewVC()
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func trendGoogleTapped(url:String) {
        let vc = WebViewVC()
        vc.url = "https://www.google.com/search?q=\(url)".addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func youtubeTapped(url:String) {
        let vc = WebViewVC()
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func trendTwitterTapped(tex:String) {
        let vc = WebViewVC()
        vc.text = tex
        vc.twitter = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadPosts(){
        if homeVM?.postsArray?.count == 0 {
            table.setEmptyView(title: "", message:Constants.messages.msgEmptyPostsList)
        }else{
            table.restore()
        }
            table.reloadData()
            handelTableHeight()
    }
    
    func reloadEventsData(){
        if homeVM?.pollsArray?.count == 0 ||  homeVM?.pollsArray?.count == nil{
            table.setEmptyView(title: "", message:Constants.messages.msgnoDataFound)
        }else{
            table.restore()
        }
        table.reloadData()
        handelTableHeight()
    }
    func pollDetails(id:Int){
        let vc = PollsDetailsVC()
        vc.surveyID = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadPollsData(){
        if homeVM?.pollsArray?.count == 0 ||  homeVM?.pollsArray?.count == nil{
            table.setEmptyView(title: "", message:Constants.messages.msgnoDataFound)
        }else{
            table.restore()
        }
            table.reloadData()
            handelTableHeight()
    }
}
// MARK: - LoginAlertViewModelDelegates --->
extension HomeVC:LoginAlertViewModelDelegates{
        func openAppStore() {}
        func checkIfUserLoggedIn(){}
        func LoginActionSuccess() {moveToLogin()}
        func logoutActionSuccess() {}
        func moveToLogin(){
            let vc = LoginVC()
            General.sharedInstance.mainNav!.pushViewController(vc, animated: true)
        }
}

// MARK: - SelectCategoryViewModelDelegate --->
extension HomeVC:SelectCategoryViewModelDelegate{
    func getTagsSuccessfully(tags: [TagsModel]?) {}
    func addTagsSuccessfully() {}
    func addCategorySuccessfully() {}
    func getCategorySuccessfully(categories:[CategoryModel]?) {}
}






    

