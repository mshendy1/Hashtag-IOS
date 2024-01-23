//
//  FilterVC.swift
//  HashTag
//
//  Created by Eman Gaber on 21/02/2023.
//

import UIKit

class NewsFilterVC: UIViewController {
    @IBOutlet weak var categoriesCollection:UICollectionView!
    @IBOutlet weak var tagsCollection:UICollectionView!
    @IBOutlet weak var categoriesCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var viewHeight:NSLayoutConstraint!
 
// MARK: - Variables
    
    var selectCategoryVM:SelectCategoryViewModel?
    var selectionCatArray : [Bool] = []
    var categories:[CategoryModel]?
    var selectedCatId : [Int] = []
    var selectedCategories:[CategoryModel] = []
    var lastSelectedIndexPath:IndexPath?
    var selectionTagsArray : [Bool] = []
    var tags:[TagsModel]?
    var selectedTags:[TagsModel] = []
    var selectedTagsId : [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        selectCategoryVM = SelectCategoryViewModel(delegate: self)
        callFilterApi()
    }

    func callFilterApi(){
        if isConnectedToInternet(){
            selectCategoryVM?.callGetCategoryApi()
            selectCategoryVM?.callGetTagsApi()
        }else{
            selectCategoryVM?.delegate?.connectionFailed()
        }
    }
    
    @IBAction func closeAction() {
        self.dismiss(animated: true)
    }

    @IBAction func continueAction(){
        if self.selectedCatId.count == 0 {
            showErrorAlert(message: Constants.messages.plzSelectCats)
        }else if selectedTagsId.count == 0{
            showErrorAlert(message: Constants.messages.plzselectTags)
        }else
        {
            General.sharedInstance.selectedCategories = self.selectedCategories
            General.sharedInstance.selectedCatId = self.selectedCatId
            
            General.sharedInstance.selectedTags = self.selectedTags
            General.sharedInstance.selectedTagId = self.selectedTagsId

            NotificationCenter.default.post(name: Notification.Name("reloadCategoriesFilter"), object: nil,userInfo:nil)
            self.dismiss(animated: true)
        }
    }

}
