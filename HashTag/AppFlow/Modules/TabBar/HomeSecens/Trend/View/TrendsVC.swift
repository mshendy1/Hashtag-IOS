//
//  TrendsVC.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation
import UIKit
enum TrendsType {
    case twitter
    case youtube
    case google
    case googleNews
}
class TrendsVC:UIViewController{
    //MARK: - outlets
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var trendCollection:UICollectionView!
   
    //MARK: - variables
    var currentPage = 0
    var allPostsPage = 1
    var allEventsPage = 1
    var allPollsPage = 1
    let uuid = UserData.shared.deviceId ?? ""
    var selectedTrendType : TrendsType!
    var trendVM:TrendsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        trendVM = TrendsViewModel(delegate: self)
        setupTrendCollection()
        setupTableVC()
        self.selectedTrendType = .youtube
    }
    override func viewWillAppear(_ animated: Bool) {
        switch self.selectedTrendType{
        case .twitter:
            trendVM?.callGetTrendsTwitterApi()
        case .youtube:
            trendVM?.callGetTrendsYoutubeApi()
        case .google:
            trendVM?.callGetTrendsGoogleApi()
        case .googleNews:
            trendVM?.callGetTrendsNewsApi()
        case .none:
            break
        }
    }


}

