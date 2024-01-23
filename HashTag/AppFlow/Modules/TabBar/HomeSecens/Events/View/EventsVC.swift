//
//  EventsVC.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation
import UIKit
import FSCalendar

class EventsVC:UIViewController{
    //MARK: - outlets
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var addEventView:UIView!
    @IBOutlet weak var btnAddEvent:UIButton!
    @IBOutlet weak var CalenderView: UIView!
    @IBOutlet weak var calenderTable: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var viewCalenderHeight: NSLayoutConstraint!

    
    //MARK: - variables
    var isFilter = false
    var currentPage = 0
    var allEventsPage = 1
    var calenderStyle = false
    var eventVM:EventsViewModel?
    var selectCategoryVM:SelectCategoryViewModel?
    let uuid = UserData.shared.deviceId ?? ""
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    var filteredEvents:[EventModel?] = []
    lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
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

        setupTableVC()
        setUpCalenderTable()
        eventVM = EventsViewModel(delegate: self)
        callAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadEvents), name: .init("reloadEvents"), object: nil)

        
        
    }

    
    
    //MARK: - properites
    
    func callAPI(){
        if isConnectedToInternet(){
            eventVM?.callGetEventsApi(category_id: General.sharedInstance.selectedCatId, city_id:General.sharedInstance.selectedCountryIdNews, page: allEventsPage)
            eventVM?.callGetCountriesApi()
        }else{
            eventVM?.delegate?.connectionFailed()
        }
    }
    
    @objc func reloadEvents(){
        isFilter = true
        eventVM?.callGetEventsApi(category_id: General.sharedInstance.selectedCountryIdNews, city_id: General.sharedInstance.selectedCatIdNews, page: allEventsPage)
    }
    //MARK: - Actions
    @IBAction func eventsFilterAction(_ sender:UIButton){
        eventVM?.delegate?.eventsFilterTapped()
    }
    
    @IBAction func createEventAction(_ sender:UIButton){
        eventVM?.delegate?.createEventTapped()
    }
    
      @IBAction func claenderAction(_ sender:UIButton){
          if calenderStyle == false{
              CalenderView.isHidden = false
              table.isHidden = true
              calenderStyle = true
//              tableHeight.constant = tableHeightOrgin
//              viewHeight.constant = viewHeightOrgin
              self.loadViewIfNeeded()
          }else{
              CalenderView.isHidden = true
              table.isHidden = false
              calenderStyle = false
          }
      }
}
extension EventsVC: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
           return ResetPasswordPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
