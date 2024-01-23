//
//  SelectCategoriesVC.swift
//  HashTag
//
//  Created by Mohamed Shendy on 05/02/2023.
//

import UIKit

class SelectCategoriesVC: UIViewController {
    @IBOutlet var header: AuthNavigation!
    @IBOutlet weak var categoriesCollection:UICollectionView!
    
    var selectionArray : [Bool] = []
    var selectCategoryVM:SelectCategoryViewModel?
    var selectedCatId : [Int] = []
    
    var lastSelectedIndexPath:IndexPath?
    var categories:[CategoryModel]?
    var tags:[TagModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.selectCatTitle
        header.switchNotificattion.isHidden = true
        selectCategoryVM = SelectCategoryViewModel(delegate: self)
        callAddCategoryApi()
    }
    
    func callAddCategoryApi(){
        if isConnectedToInternet(){
            selectCategoryVM?.callGetCategoryApi()
        }else{
            selectCategoryVM?.delegate?.connectionFailed()
        }
    }

    @IBAction func continueAction(){
        if selectedCatId.count == 0 {
            showErrorAlert(message:Constants.messages.msgSelectCategory)
        }else {
            if isConnectedToInternet(){
                selectCategoryVM?.callAddCategoryApi(categoryId: self.selectedCatId)
            }else{
                selectCategoryVM?.delegate?.connectionFailed()
            }
        }
    }
}


extension SelectCategoriesVC:AuthNavigationDelegate{
    func turAction() {}
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}


