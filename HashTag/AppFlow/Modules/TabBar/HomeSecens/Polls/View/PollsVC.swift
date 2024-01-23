//
//  PollsVC.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//


import Foundation
import UIKit

class PollsVC:UIViewController{
    //MARK: - outlets
    @IBOutlet weak var table:UITableView!

    //MARK: - variables
    let uuid = UserData.shared.deviceId ?? ""
    var currentPage = 0
    var allPollsPage = 1
    var PollsVM:PollsViewModel?
    var loginAlertVM:LoginAlertViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        PollsVM = PollsViewModel(delegate: self)
        loginAlertVM = LoginAlertViewModel(delegate: self)
        setupTableVC()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadPolls), name: .init("reloadPolls"), object: nil)
        allPollsPage = 1
        PollsVM?.callGetPollsApi(page: allPollsPage)
        
    }

    //MARK: - properites
    @objc func reloadPolls(){
        table.reloadData()
        PollsVM?.callGetPollsApi(page: allPollsPage)
    }


    //MARK: - Actions

}
