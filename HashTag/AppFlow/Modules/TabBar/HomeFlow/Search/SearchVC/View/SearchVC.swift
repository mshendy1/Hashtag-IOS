//
//  SearchVC.swift
//  E-CommerceApp
//
//  Created by Eman Gaber on 27/06/2022.
//

import UIKit
import LanguageManager_iOS

class SearchVC: UIViewController, UITextFieldDelegate,UISearchBarDelegate{
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var tfkeyword:UITextField!
    @IBOutlet weak var searchBar:UISearchBar!
    var searchVM:SearchViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        tfkeyword.placeholder = Constants.messages.emptysearchText
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.searchTitle
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        searchVM = SearchViewModel(delegate: self)
        tfkeyword.delegate = self
        searchBar.delegate = self
        searchBar.placeholder = Constants.messages.emptysearchText
        searchBar.backgroundColor = Colors.lightGray
        searchBar.contentMode = .scaleAspectFill
          }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
        if searchBar.text == ""  {
            showError(error: Constants.messages.emptysearchText)
        }else{
            searchVM.getSearchItemsAPI(name: searchBar.text!)
        }
    }
    @IBAction func searchAction(_sender:UIButton){}


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchVM?.searchItemsArr = []
        table.reloadData()
    }
    
  
    
}

extension SearchVC:AuthNavigationDelegate{
    func turAction() {
        
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
   
}
