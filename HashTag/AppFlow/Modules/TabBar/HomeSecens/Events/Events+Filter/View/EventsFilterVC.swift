//
//  HashTag
//
//  Created by Eman Gaber on 21/02/2023.
//

import UIKit

class EventsFilterVC: BaseBottomSheetViewController {
  
    @IBOutlet weak var categoriesCollection:UICollectionView!
    @IBOutlet weak var countriesCollection:UICollectionView!
    @IBOutlet weak var categoriesCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var viewHeight:NSLayoutConstraint!

    var selectionCatArray : [Bool] = []
    var selectionCountriesArray : [Bool] = []
    var selectCategoryVM:SelectCategoryViewModel?
    var eventVM:EventsViewModel?
    var lastSelectedIndexPath:IndexPath?
    var categories:[CategoryModel]?
    var countries:[CountriesModel?]?
    var selectedCategories:[CategoryModel] = []
    var selectedCountries:[CountriesModel?] = []
    var selectedCatId : [Int] = []
    var selectedCountryId : [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        selectCategoryVM = SelectCategoryViewModel(delegate: self)
        eventVM = EventsViewModel(delegate: self)
        setupCollection()
        callFilterApi()
    }
    
    
    func callFilterApi(){
        if isConnectedToInternet(){
            selectCategoryVM?.callGetCategoryApi()
            eventVM?.callGetCountriesApi()
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
        }else if selectedCountryId.count == 0{
            showErrorAlert(message: Constants.messages.plzselectTags)
        }else
        {
            General.sharedInstance.selectedCategoriesNews = self.selectedCategories
            General.sharedInstance.selectedCatIdNews = self.selectedCatId
            
            General.sharedInstance.selectedCountriesNews = self.selectedCountries
            General.sharedInstance.selectedCountryIdNews = self.selectedCountryId
            
            NotificationCenter.default.post(name: Notification.Name("reloadEvents"), object: nil,userInfo:nil)
            self.dismiss(animated: true)
            
        }
    }

}
