//
//  FavouritesVC.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.
//

import UIKit
enum SearchTypes {
    case news
    case surveys
    case events
}
class SearchOutsVC: UIViewController{
    
    @IBOutlet weak var table:UITableView!
    //    @IBOutlet weak var tableHeight:NSLayoutConstraint!
    //    @IBOutlet weak var viewHeight:NSLayoutConstraint!
    @IBOutlet weak var btnNews:UIButton!
    @IBOutlet weak var btnEvents:UIButton!
    @IBOutlet weak var btnSurveys:UIButton!
    @IBOutlet weak var header:AuthNavigation!
    var eventsTableCellHeight = 305.0
    var newsPostsTableCellHeight = 361.0
    var NewsVideoTablecellHeihht = 205.0
    var surveysTableCellHeight = 238.0
    
    var searchKeyWord:String?
    var type : SearchTypes!
    var searchOutsVM:SearchsOutPutViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableVC()
        newsTapped()
        searchOutsVM = SearchsOutPutViewModel(delegate: self)
        self.type = .news
        CallApi()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //   header.delegate = self
        header.btnBack.isHidden =  true
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        header.lblTitle.text = Constants.PagesTitles.searchTitle
    }
    
    
    
        func CallApi(){
            if isConnectedToInternet(){
                searchOutsVM?.callSearchApi(keyWord:searchKeyWord ?? "")
                
            }else{
                searchOutsVM?.delegate?.connectionFailed()
            }
        }

    
    
    @IBAction func newsAction(_sender:UIButton){
        self.type = .news
        searchOutsVM?.delegate?.newsTapped()
        if isConnectedToInternet(){
            searchOutsVM?.callSearchApi(keyWord:searchKeyWord ?? "")
        }else{
            searchOutsVM?.delegate?.connectionFailed()
        }
    }
    
    @IBAction func surveysAction(_sender:UIButton){
        self.type = .surveys
        searchOutsVM?.delegate?.surveysTapped()
        if isConnectedToInternet(){
            searchOutsVM?.callSearchApi(keyWord:searchKeyWord ?? "")
        }else{
            searchOutsVM?.delegate?.connectionFailed()
        }
    }
    
    @IBAction func eventAction(_sender:UIButton){
        self.type = .events
        searchOutsVM?.delegate?.eventsTapped()
        if isConnectedToInternet(){
            searchOutsVM?.callSearchApi(keyWord:searchKeyWord ?? "")
        }else{
            searchOutsVM?.delegate?.connectionFailed()
        }
    }
    
}
extension SearchReultsVC:AuthNavigationDelegate{

    func turAction() {
    }

    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}
