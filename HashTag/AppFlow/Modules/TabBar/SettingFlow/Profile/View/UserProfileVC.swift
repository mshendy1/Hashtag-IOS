//
//  UserProfileVC.swift
//  HashTag
//
//  Created by Trend-HuB on 13/08/1444 AH.
//

import UIKit
import Photos
import QCropper

class UserProfileVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var btnDOB:UIButton!
    @IBOutlet weak var btnChangePassword:UIButton!
    @IBOutlet weak var imgeGender:UIImageView!
    @IBOutlet weak var btnGendeTypesMenue:UIButton!
    @IBOutlet weak var btnUploadImage:UIButton!
    @IBOutlet weak var btnSave:UIButton!
    @IBOutlet weak var tfName:UITextField!
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPhone:UITextField!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblEmail:UILabel!
    @IBOutlet weak var userImg:UIImageView!
    @IBOutlet weak var viewEditePhoto:UIView!

    var UserProfileVM:UserProfileViewModel!
    var selectedGenderId :Int?
    var selectecDateOfBirth:String?
    var selectedImage:UIImage?
    var isEditting = false
    var type = ""
    
    var originalImage: UIImage?
    var cropperState: CropperState?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        header.delegate = self
        header.lblTitle.text = Constants.PagesTitles.profileTitle
        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        guard let dateOfBirth = UserData.shared.userDetails?.dateOfBirth  else {return}
        btnDOB.setTitle(dateOfBirth, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            UserProfileVM = UserProfileViewModel(delegate: self)
            setupTableVC()
            UserProfileVM?.delegate?.setUILocalize()
            callGetProfileDataAPI()
    }
    
    @IBAction func claenderAction(_ sender:UIButton){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US")
        CustomDatePicker.instance.date = Date()
        CustomDatePicker.instance.returnDateOfBirth(max: Calendar.current.date(byAdding: .year, value: 0, to: Date()) ?? Date()) { [self] (selectedDate) in
            selectecDateOfBirth = selectedDate
            btnDOB.setTitle(selectedDate, for: .normal)
        }
    }
    
    @IBAction func genderAction(_ sender:UIButton){
        table.isHidden = !table.isHidden
        table.reloadData()
    }
  
    @IBAction func startEdittingAction(_ sender:UIButton){}

    @IBAction func saveEdittingAction(_ sender:UIButton){
        self.view.endEditing(true)
        if tfName.text != "" && tfEmail.text != "" && tfPhone.text != "" && selectecDateOfBirth != nil && selectedGenderId != nil {
            callEditProfile()
           }
        else{
            showErrorAlert(message:Constants.messages.msgFillEmptyFields)
        }
    }
    @IBAction func openChangePassword(_ sender:UIButton){
        UserProfileVM?.delegate?.openChangePassword()
    }
    
    @IBAction func uploadImgTapped(_ sender:UIBarButtonItem){
        uploadImgAlert()
    }
    
    @objc
    func reeditButtonPressed(_: UIButton) {
        if let image = originalImage, let state = cropperState {
            let cropper = CropperViewController(originalImage: image, initialState: state)
            cropper.delegate = self
            present(cropper, animated: true, completion: nil)
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
        if isConnectedToInternet(){
    let parameters = ["email":tfEmail.text!,
                      "name":tfName.text!,
                      "phone":tfPhone.text!,
                      "date_of_birth":selectecDateOfBirth!,
                      "gender_id":selectedGenderId!] as [String : Any]
            UserProfileVM?.callEditProfileApi(parameters:parameters,image:selectedImage)
        }else{
            self.showNoInternetAlert()
        }
    }
    
    func uploadImgAlert(){
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = (info[.originalImage] as? UIImage) else { return }
        originalImage = image
        let cropper = CropperViewController(originalImage: image)
        cropper.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropper, animated: true, completion: nil)
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
extension UserProfileVC: CropperViewControllerDelegate {
    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
        cropper.dismiss(animated: true, completion: nil)

        if let state = state,
            let image = cropper.originalImage.cropped(withCropperState: state) {
            cropperState = state
            userImg.image = image
            selectedImage = image
            print(cropper.isCurrentlyInInitialState)
            print(image)
        }
    }
}


