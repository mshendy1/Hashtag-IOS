//
//  HomeViewController.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import UIKit
import LanguageManager_iOS
import DropDown
import FSCalendar
enum SelectType {
    case news
    case surveys
    case events
    case twitter
    case youtube
    case google
    case googleNews
}
class HomeVC: UIViewController {
    
    @IBOutlet weak var header: TabBarHeader!
    @IBOutlet weak var trendCollection:UICollectionView!
    @IBOutlet weak var homeCategoriesCollection:UICollectionView!
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var categorizeStack:UIStackView!
    @IBOutlet weak var CategorisView:UIView!
    @IBOutlet weak var tableHeight:NSLayoutConstraint!
    @IBOutlet weak var viewHeight:NSLayoutConstraint!
    @IBOutlet weak var btnNews:UIButton!
    @IBOutlet weak var btnTrend:UIButton!
    @IBOutlet weak var btnSurveys:UIButton!
    @IBOutlet weak var btnEvents:UIButton!
    @IBOutlet weak var addEventView:UIView!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var btnAddEvent:UIButton!
    @IBOutlet weak var CalenderView: UIView!
    @IBOutlet weak var calenderTable: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var viewCalenderHeight: NSLayoutConstraint!
    @IBOutlet weak var newsUnderView: UIView!
    @IBOutlet weak var eventsUnderView: UIView!
    @IBOutlet weak var TrensUnderView: UIView!
    @IBOutlet weak var pollsUnderView: UIView!
    @IBOutlet weak var viewIndicator: UIView!
   
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    var filteredEvents:[EventModel?] = []

    lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var selectedType : SelectType!
    var viewHeightOrgin = 0.0
    var tableHeightOrgin = 100.0
    var homeVM:HomeViewModel?
    var loginAlertVM:LoginAlertViewModel?
    var selectCategoryVM:SelectCategoryViewModel?
    var isFilter = false
    var selectecDateOfBirth = ""
    var eventsTableCellHeight = 213.0
    var newsPostsTableCellHeight = 340.0
    var surveysTableCellHeight = 229.0
    var twitterTableCellHeight = 76.0
    var googleNewsTableCellHeight = 212.0
    var youtubeTableCellHeight = 361.0
    var NewsVideoTablecellHeihht = 341.0
    var calenderEventCellHeight = 72.0
    var selectedCountryId :Int?
    var selectedCategoryId :Int?
    var selectedImage:UIImage?
    let refreshControl = UIRefreshControl()
    let uuid = UserData.shared.deviceId ?? ""
    var currentPage = 0
    var allPollsPage = 1
    var allPostsPage = 1
    var allEventsPage = 1
    var id:String!
    var calenderStyle = false
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        loginAlertVM = LoginAlertViewModel(delegate: self)
        selectCategoryVM = SelectCategoryViewModel(delegate: self)
        selectCategoryVM?.callGetCategoryApi()
        callHomeApi()
        setupTableVC()
        setUpCalenderTable()
        setupTrendCollection()
        setupCategoriesCollection()
        setLocalization()
        if homeVM != nil {//  refresh home
            allPostsPage = 1
            allEventsPage = 1
            allPollsPage = 1
            switch self.selectedType{
            case .news:
                homeVM?.callGetPostsApi(category_id:[], tag_id: [], page: allPostsPage)
            case .events:
                homeVM?.callGetEventsApi(category_id: General.sharedInstance.selectedCatId, tag_id: [], page: allEventsPage)
            case .surveys:
                homeVM?.callGetPollsApi(page: allPollsPage)
            case .twitter:
                homeVM?.callGetTrendsTwitterApi()
            case .youtube:
                homeVM?.callGetTrendsYoutubeApi()
            case .google:
                homeVM?.callGetTrendsGoogleApi()
            case .googleNews:
                homeVM?.callGetTrendsNewsApi()
            case .none:
                break
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(reloadFilterNews), name: .init("reloadNewsFilter"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(reloadFilterCat), name: .init("reloadCategoriesFilter"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(reloadPolls), name: .init("reloadPolls"), object: nil)
          
            NotificationCenter.default.addObserver(self, selector: #selector(reloadEvents), name: .init("reloadEvents"), object: nil)
        }
        
        let apnsUserInfo = UserDefaults.standard.getUserInfo()
        print(apnsUserInfo)
       if apnsUserInfo.isEmpty == false {
           let type = apnsUserInfo["type"] as! String
           let id = apnsUserInfo["id"] as! String
           if type == "news"{
                   self.homeVM?.outputDelegate?.moveToPostDetails(id: Int(id) ?? 0)
           }else if type == "event"{
                   self.homeVM?.outputDelegate?.moveToEventDetails(id: Int(id) ?? 0)
           }else{
                   self.homeVM?.outputDelegate?.moveToPollDetails(id: Int(id) ?? 0)
           }
           UserDefaults.standard.removeObject(forKey:UserDefaultsKeys.userInfo.rawValue)
       }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // set in first time open screen
        viewHeightOrgin = viewHeight.constant
        tableHeightOrgin = tableHeight.constant
        scrollView.delegate = self
        header.delegate = self
        if !UserDefaults.standard.isLoggedIn(){
            header.lblUserName.isHidden = true
        }else if General.sharedInstance.socialLoginType == Constants.appWords.apple {
            header.lblUserName.text = KeychainItem.currentUserName
        }else{
            let name = UserData.shared.userDetails?.name ?? ""
                header.lblUserName.text = name
        }
        homeVM = HomeViewModel(delegate: self, outputDelegate: self)
        callHomeApi()
        homeVM?.outputDelegate?.newsTapped()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.select(Date())
        calendar.scope = .month
        calendar.accessibilityIdentifier = "calendar"
        calendar.appearance.titleFont = FontManager.font(withSize: 18,style: .regular)
        calendar.appearance.separators = .interRows
        calendar.configureAppearance()
        calendar.appearance.weekdayFont = FontManager.font(withSize: 18,style: .medium)
        calendar.appearance.headerTitleFont = FontManager.font(withSize: 18,style: .medium)
        calendar.appearance.subtitleFont = FontManager.fontWithSize(size: 18)
        calendar.appearance.subtitleFont = FontManager.fontWithSize(size: 18)
        calendar.headerHeight = 40
                
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        table.addSubview(refreshControl) // not required when using UITableViewController

    }
    

    @objc func refreshData(_ sender: UIRefreshControl) {
        // Update your data here
        selectCategoryVM?.callGetCategoryApi()
        viewHeightOrgin = viewHeight.constant
        tableHeightOrgin = tableHeight.constant
        setupTableVC()
        setupTrendCollection()
        setupCategoriesCollection()
        homeVM?.outputDelegate?.reloadPosts()
        callHomeApi()
        setLocalization()
        sender.endRefreshing()
    }
    @objc func moveToPostsDetails(notification:NSNotification) {
         let vc = PostDetailsVC()
            print("\(String(describing: id))")
        let id = notification.userInfo!["id"] as? String
         let ids = Int(id!) ?? 0
            vc.postId = ids
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moveToPollsDetails(notification:NSNotification) {
        let vc = PollsDetailsVC()
        let id = notification.userInfo!["id"] as? String
        let ids = Int(id!) ?? 0
           vc.surveyID = ids
           self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moveToEventsDetails(notification:NSNotification) {
        let vc = EventsDetailsVC()
        let id = notification.userInfo!["id"] as? String
        let ids = Int(id!) ?? 0
           vc.eventId = ids
           self.navigationController?.pushViewController(vc, animated: true)
    }

    func callHomeApi(){
        if isConnectedToInternet(){
            homeVM?.callGetEventsApi(category_id: General.sharedInstance.selectedCatId, tag_id: [], page: allEventsPage)
            homeVM?.callGetCountriesApi()

            homeVM?.callGetPostsApi(category_id:[], tag_id: [], page: allPostsPage)
            homeVM?.callGetPollsApi(page:allPollsPage)
            homeVM?.callGetTrendsTwitterApi()
            homeVM?.callGetTrendsYoutubeApi()
            homeVM?.callGetTrendsGoogleApi()
            homeVM?.callGetTrendsNewsApi()
            homeVM?.callGetCountriesApi()
            homeVM?.callGetTypessApi()
        }else{
            homeVM?.delegate?.connectionFailed()
        }
    }
    
    @objc func reloadFilterCat(){
        homeCategoriesCollection.reloadData()
        // call api again to filter posts with selected categories
        homeVM?.callGetPostsApi(category_id: General.sharedInstance.selectedCatId, tag_id: [], page: allPostsPage)
    }
    
    @objc func reloadFilterNews(){
        homeVM?.callGetEventsApiFilter(categryId: General.sharedInstance.selectedCatIdNews,countryId: General.sharedInstance.selectedCountryIdNews, date: nil)
    }
    
    @objc func reloadPolls(){
        table.reloadData()
        // call api again to filter posts with selected categories
        homeVM?.callGetPollsApi(page: allPollsPage)
    }
    
    @objc func reloadEvents(){
        table.reloadData()
        homeVM!.callGetEventsApiFilter(categryId: [1], countryId: [1], date: "")
    }
    @IBAction func menueTapped(){ }
  
    @IBAction func newsAction(_sender:UIButton){
        homeVM?.outputDelegate?.newsTapped()
    }
    @IBAction func trendAction(_sender:UIButton){
        homeVM?.outputDelegate?.trendTapped()
    }
    @IBAction func surveysAction(_sender:UIButton){
        homeVM?.outputDelegate?.surveysTapped()
    }
    @IBAction func eventAction(_sender:UIButton){
        homeVM?.outputDelegate?.eventTapped()
    }
    @IBAction func eventsFilterAction(_ sender:UIButton){
        homeVM?.outputDelegate?.eventsFilterTapped()
    }
    @IBAction func createEventAction(_ sender:UIButton){
        homeVM?.outputDelegate?.createEventTapped()
    }
    @IBAction func newsFilterAction(_ sender:UIButton){
        homeVM?.outputDelegate?.newsFilterTapped()
    }
  
    @IBAction func claenderAction(_ sender:UIButton){
        if calenderStyle == false{
            CalenderView.isHidden = false
            table.isHidden = true
            calenderStyle = true
            tableHeight.constant = tableHeightOrgin
            viewHeight.constant = viewHeightOrgin
            self.loadViewIfNeeded()
        }else{
            CalenderView.isHidden = true
            table.isHidden = false
            calenderStyle = false
        }
    }
}

extension HomeVC:TabBarHeaderDelegate{
    func openSearch() {
        homeVM?.outputDelegate?.moveToSearch()
    }
}
