//
//  SearchOutsVC.swift
//  HashTag
//
//  Created by Trend-HuB on 06/08/1444 AH.
//

import UIKit
import UIKit

enum SearchTypes {
    case news
    case surveys
    case events
}
class SearchOutsVC: UIViewController{
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var btnNews:UIButton!
    @IBOutlet weak var btnEvents:UIButton!
    @IBOutlet weak var btnSurveys:UIButton!
    @IBOutlet weak var header:AuthNavigation!
    
    let uuid = UserData.shared.deviceId ?? ""
    var eventsTableCellHeight = 200.0
    var newsPostsTableCellHeight = 361.0
    var NewsVideoTablecellHeihht = 361.0
    var surveysTableCellHeight = 238.0
    
    var searchKeyWord:String?
    var type : SearchTypes!
    var searchOutsVM:SearchsOutPutViewModel?
    var homeVM:HomeViewModel?
    var loginAlertVM:LoginAlertViewModel?
  
    override func viewWillAppear(_ animated: Bool) {
        btnNews.setTitle(Constants.home.news, for: .normal)
        btnEvents.setTitle(Constants.home.events, for: .normal)
        btnSurveys.setTitle(Constants.home.surveys, for: .normal)
        setupTableVC()
        searchOutsVM = SearchsOutPutViewModel(delegate: self)
        loginAlertVM = LoginAlertViewModel(delegate: self)
        newsTapped()
        self.type = .news
        CallSearchNewsApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.delegate = self
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        header.lblTitle.text = Constants.PagesTitles.searchTitle
    }
    
    func CallSearchNewsApi(){
        if isConnectedToInternet(){
            searchOutsVM?.callSearchApi(keyWord:searchKeyWord ?? "", type: .news)
        }else{
            searchOutsVM?.delegate?.connectionFailed()
        }
    }
    
    @IBAction func newsAction(_sender:UIButton){
        self.type = .news
        searchOutsVM?.delegate?.newsTapped()
        if isConnectedToInternet(){
            searchOutsVM?.callSearchApi(keyWord:searchKeyWord ?? "", type: .news)
        }else{
            searchOutsVM?.delegate?.connectionFailed()
        }
    }
    
    @IBAction func surveysAction(_sender:UIButton){
        self.type = .surveys
        searchOutsVM?.delegate?.surveysTapped()
        if isConnectedToInternet(){
            searchOutsVM?.callSearchApi(keyWord:searchKeyWord ?? "", type: .surveys)
        }else{
            searchOutsVM?.delegate?.connectionFailed()
        }
    }
    
    @IBAction func eventAction(_sender:UIButton){
        self.type = .events
        searchOutsVM?.delegate?.eventsTapped()
        if isConnectedToInternet(){
            searchOutsVM?.callSearchApi(keyWord:searchKeyWord ?? "", type: .events)
        }else{
            searchOutsVM?.delegate?.connectionFailed()
        }
    }
}

extension SearchOutsVC:AuthNavigationDelegate{
    func turAction() {}
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}
