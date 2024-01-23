//
//  FavouritesVC.swift
//  HashTag
//
//  Created by Eman Gaber on 25/02/2023.
//

import UIKit
enum Types {
    case news
    case surveys
    case events
}
class FavouritesVC: UIViewController {
    
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var btnNews:UIButton!
    @IBOutlet weak var btnEvents:UIButton!
    @IBOutlet weak var btnSurveys:UIButton!
    @IBOutlet weak var header:AuthNavigation!
    var eventsTableCellHeight = 200.0
    var newsPostsTableCellHeight = 340.0
    var NewsVideoTablecellHeihht = 340.0
    var surveysTableCellHeight = 238.0
    var fromSearch:Bool?
    var searchKeyWord:String?
    var type : Types!
    var FavouritsVM:FavouritesViewModel?
    var loginAlertVM:LoginAlertViewModel?
    let uuid = UserData.shared.deviceId
    override func viewWillAppear(_ animated: Bool) {
        setupTableVC()
        FavouritsVM = FavouritesViewModel(delegate: self)
        loginAlertVM = LoginAlertViewModel(delegate: self)
        CallApi(deviceId:uuid ?? "")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnNews.setTitle(Constants.home.news, for: .normal)
        btnEvents.setTitle(Constants.home.events, for: .normal)
        btnSurveys.setTitle(Constants.home.surveys, for: .normal)
        newsTapped()
        self.type = .news
        header.delegate = self
        header.btnBack.isHidden =  true
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
            header.lblTitle.text = Constants.PagesTitles.favTitle
    }
    
    func CallApi(deviceId:String){
        if isConnectedToInternet(){
            if UserDefaults.standard.isLoggedIn(){
                FavouritsVM?.callGetFavPostsApi(deviceId:"")
            }else{
                FavouritsVM?.callGetFavPostsApi(deviceId:uuid ?? "")
            }
        }else{
            FavouritsVM?.delegate?.connectionFailed()
        }
    }
    
  

    @IBAction func newsAction(_sender:UIButton){
        self.type = .news
       
        FavouritsVM?.delegate?.newsTapped()
        if isConnectedToInternet(){
            if UserDefaults.standard.isLoggedIn(){
                FavouritsVM?.callGetFavPostsApi(deviceId:"")
            }else{
                FavouritsVM?.callGetFavPostsApi(deviceId:uuid ?? "")
            }
        }else{
            FavouritsVM?.delegate?.connectionFailed()
        }
    }
    
    @IBAction func surveysAction(_sender:UIButton){
        self.type = .surveys
        FavouritsVM?.delegate?.surveysTapped()
        if isConnectedToInternet(){
            if UserDefaults.standard.isLoggedIn(){
                
                FavouritsVM?.callGeFavPollsApi(deviceId: "")
            }else{
                FavouritsVM?.callGeFavPollsApi(deviceId:uuid ?? "")
            }
        }else{
            FavouritsVM?.delegate?.connectionFailed()
        }
    }
    
    @IBAction func eventAction(_sender:UIButton){
        self.type = .events
        FavouritsVM?.delegate?.eventsTapped()
        if isConnectedToInternet(){
            if UserDefaults.standard.isLoggedIn(){
                FavouritsVM?.callGetFavEventsApi(deviceId:"")
            }else{
                FavouritsVM?.callGetFavEventsApi(deviceId:uuid ?? "")
            }
        }else{
            FavouritsVM?.delegate?.connectionFailed()
        }
    }
}

extension FavouritesVC:AuthNavigationDelegate{
    
    func turAction() {
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
