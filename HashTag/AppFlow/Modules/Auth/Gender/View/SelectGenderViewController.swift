//
//  SelectGenderViewController.swift
//  HashTag
//
//  Created by Mohamed Shendy on 05/02/2023.
//

import UIKit

class SelectGenderViewController: UIViewController {

    
    @IBOutlet weak var genderCollection:UICollectionView!
    @IBOutlet var header: AuthNavigation!
    @IBOutlet var lblDOB: UILabel!
   
    var selectGenderVM:RegisterViewModel?
    var selectionIndex = -1
    var genderId = -1
    var lastSelectedIndexPath:IndexPath?
    var name = ""
    var phone = ""
    var password = ""
    var selectecDateOfBirth = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.delegate = self
        header.switchNotificattion.isHidden = true
        header.lblTitle.isHidden = true
        selectGenderVM = RegisterViewModel(twitterDelegate: self, delegate: self, outputDelegate: self)
        setupCollection()
    }
    
    @IBAction func dateOfBirthAction(){
        if !selectecDateOfBirth.isEmpty {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US")
        CustomDatePicker.instance.date = formatter.date(from: selectecDateOfBirth)!
        
        }
        
        CustomDatePicker.instance.returnDateOfBirth(max: Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()) { [self] (selectedDate) in
            selectecDateOfBirth = selectedDate
            lblDOB.text = selectedDate
        }
    }
    
    @IBAction func continuAction()
    {
       if selectionIndex == -1{
           showErrorAlert(message: "Please select gender".localiz())
       }else
           if selectecDateOfBirth == "" {
           showErrorAlert(message: "Please select date of birth".localiz())

       }else {
           selectGenderVM?.callRegisterStepTwoApi( genderId: genderId, dateOfBirth: selectecDateOfBirth)
       }
    }
    
    func moveToSelectCategories(){
        let vc = SelectCategoriesVC()
        self.navigationController?.pushViewController(vc, animated:true)
    }
}

extension SelectGenderViewController:AuthNavigationDelegate{
    func turAction() {}
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

