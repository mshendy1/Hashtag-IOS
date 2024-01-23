//
//  NewsVC.swift
//  HashTag
//
//  Created by Trend-HuB on 01/03/1445 AH.
//

import Foundation
import UIKit

class NewsVC:UIViewController{
 
    //MARK: - outlets
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var CategoriesCollection:UICollectionView!
  
    //MARK: - variables
    let uuid = UserData.shared.deviceId ?? ""
    var currentPage = 0
    var allPostsPage = 1
    var newsVM:NewsViewModel?
    var selectCategoryVM:SelectCategoryViewModel?
    var loginAlertVM:LoginAlertViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        newsVM = NewsViewModel(delegate: self)
        selectCategoryVM = SelectCategoryViewModel(delegate: self)
        loginAlertVM = LoginAlertViewModel(delegate: self)
        allPostsPage = 1
        setupTableVC()
        setupCategoriesCollection()
        callAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFilterCat), name: .init("reloadCategoriesFilter"), object: nil)
    }

    //MARK: - properites
    func callAPI(){
        if isConnectedToInternet(){
            selectCategoryVM?.callGetCategoryApi()
            newsVM?.callGetPostsApi(category_id: [], tag_id: [], page: allPostsPage)
        }else{
            newsVM?.delegate?.connectionFailed()
        }
    }
 
    
    @objc func reloadFilterCat(){
       CategoriesCollection.reloadData()
        newsVM?.callGetPostsApi(category_id: General.sharedInstance.selectedCatId, tag_id: [], page: allPostsPage)
    }
    
    //MARK: - Actions
    @IBAction func newsFilterAction(_ sender:UIButton){
        newsVM?.delegate?.newsFilterTapped()
    }
    
}
//MARK: - Extension

extension NewsVC: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
           return ResetPasswordPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
