//
//  UserProfileVC.swift
//  HashTag
//
//  Created by Trend-HuB on 13/08/1444 AH.
//

import UIKit
import Photos

class UserProfileVC: UIViewController {
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var btnDOB:UIButton!
    @IBOutlet weak var btnSave:UIButton!
    @IBOutlet weak var btnChangePassword:UIButton!
    @IBOutlet weak var imgeGender:UIImageView!
    @IBOutlet weak var btnGendeTypesMenue:UIButton!
    @IBOutlet weak var btnEdit:UIButton!
    @IBOutlet weak var btnUploadImage:UIButton!

    @IBOutlet weak var tfName:UITextField!
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPhone:UITextField!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblEmail:UILabel!
    @IBOutlet weak var userImg:UIImageView!
    
    var UserProfileVM:UserProfileViewModel!
    var selectedGenderId :Int?
    var selectecDateOfBirth:String?
    var selectedImage:UIImage?
    var isEditting = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        UserProfileVM = UserProfileViewModel(delegate: self)
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.profileTitle
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
//        setupTableVC()
        UserProfileVM?.delegate?.setUILocalize()
        callGetProfileDataAPI()
    }
    
    @IBAction func claenderAction(_ sender:UIButton){
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.locale = Locale(identifier: "en_US")
//        CustomDatePicker.instance.date = Date()
//        CustomDatePicker.instance.returnDateOfBirth(max: Calendar.current.date(byAdding: .year, value: 0, to: Date()) ?? Date()) { [self] (selectedDate) in
//            selectecDateOfBirth = selectedDate
//            btnDOB.setTitle(selectedDate, for: .normal)
//        }
    }
    
    @IBAction func genderAction(_ sender:UIButton){
//        table.isHidden = !table.isHidden
//        table.reloadData()
    }
    @IBAction func editeAction(_ sender:UIButton){
        isEditting = true
        tfName.isUserInteractionEnabled = true
        tfPhone.isUserInteractionEnabled = true
        tfEmail.isUserInteractionEnabled = true
        btnUploadImage.isUserInteractionEnabled = true

    }
    
    @IBAction func saveEdittingAction(_ sender:UIButton){
        self.view.endEditing(true)
        if tfName.text != "" && tfEmail.text != "" && tfPhone.text != ""{
            callEditProfile()
        }
        else{
            showErrorAlert(message: "Please fill all fields".localiz())
        }
    }
    
    func callGetProfileDataAPI(){
        if isConnectedToInternet(){
            UserProfileVM.getProfileAPI()
        }else{
            UserProfileVM.delegate?.connectionFailed()
        }
    }
    
    func callEditProfile(){
        if isConnectedToInternet()
        {
    let parameters = ["email":tfEmail.text!,
                              "name":tfName.text!,"mobile":tfPhone.text!] as [String : Any]
            UserProfileVM?.callEditProfileApi(parameters:parameters,image:selectedImage)
        }else{
            self.showNoInternetAlert()
        }
    }
    


    
    @IBAction func openChangePassword(_ sender:UIButton){
        UserProfileVM?.delegate?.openChangePassword()
    }
    
    

    
    @IBAction func uploadImgTapped(_ sender:UIBarButtonItem){
      //  self.view.endEditing(true)
        
        let actionSheet = UIAlertController(title: ConstantsUploadFile.actionFileTypeHeading.localiz(), message: ConstantsUploadFile.actionFileTypeDescription.localiz(), preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: ConstantsUploadFile.camera.localiz(), style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .camera)
        }))
        actionSheet.addAction(UIAlertAction(title: ConstantsUploadFile.phoneLibrary.localiz(), style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .photoLibrary)
        }))
        actionSheet.addAction(UIAlertAction(title: ConstantsUploadFile.cancelBtnTitle.localiz(), style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
    }
 
}

extension UserProfileVC:AuthNavigationDelegate{
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func turAction() {}
}


extension UserProfileVC:ChangePasswordDelegate{
    func dismissChangePassword() {
        self.dismiss(animated: true)
    }
  
}

