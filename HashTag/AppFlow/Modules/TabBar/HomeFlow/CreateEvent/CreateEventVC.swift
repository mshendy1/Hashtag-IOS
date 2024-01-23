//
//  CreateEventVC.swift
//  HashTag
//
//  Created by Trend-HuB on 06/08/1444 AH.
//

import UIKit
import DropDown
import LanguageManager_iOS
import AVFoundation

class CreateEventVC: UIViewController,UITextViewDelegate {
    var eventVM:EventsViewModel?
    //var selectCategoryVM:SelectCategoryViewModel?
    var countryDropDown = DropDown()
    var categoriesDropDown = DropDown()
    var selectedCountryId :Int?
    var videoPath:URL?
    var selectedImage:UIImage?
    var media_type:String?
    var selectLat :String?
    var selectLang :String?
    var selectedAddress:String?
    var selectedDateAndTime:String?
    var createEventVM:CreateEventViewModel?
    var selectedCategoriesId:Int?
    var selectionTypesArray:[Bool] = []
    var types:[TypesModel]?
    var selectedId : [Int] = []
    var selectedTypes:[TypesModel] = []
    var fromMyEvents:Bool?

    @IBOutlet weak var placeHolderLbl:UILabel!
    @IBOutlet weak var btnCountry:UIButton!
    @IBOutlet weak var btnCategory:UIButton!
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var btnCategoryTypesMenue:UIButton!
    @IBOutlet weak var btnCountryMenue:UIButton!
    @IBOutlet weak var btnDOB:UIButton!
    @IBOutlet weak var btnAddrress:UIButton!

    @IBOutlet weak var tfTitle:UITextField!
    @IBOutlet weak var tvDetails:UITextView!
    @IBOutlet weak var tfCreator:UITextField!
    @IBOutlet weak var tfwebsite:UITextField!
//    @IBOutlet weak var tfFacebook:UITextField!
    @IBOutlet weak var tfTwitter:UITextField!
    @IBOutlet weak var tfPhone:UITextField!
    @IBOutlet weak var tfInstagram:UITextField!
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var videoEventImg: UIImageView!
    @IBOutlet weak var collection: UICollectionView!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

      override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        createEventVM = CreateEventViewModel(delegate: self)
        callEvntTypesApi()
        header.switchNotificattion.isHidden = true
        header.img.isHidden = true
        header.delegate = self
        header.lblTitle.text = "Create new event".localiz()
        let email = UserData.shared.userDetails
        tfEmail.text = email?.email
        print( UserData.shared.userDetails?.email  ?? "")
        self.navigationController?.isNavigationBarHidden = true
        
        if LanguageManager.shared.isRightToLeft {
            btnCountry.contentHorizontalAlignment = .right
            tvDetails.textAlignment = .right
        }
          
          createEventVM?.callGetCountriesApi()
       // setupCountriesMenu()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.SetSelectedAddressAction),
            name: NSNotification.Name(rawValue: "setSelectedAddress"),
            object: nil)

        AttachmentHandler.shared.imagePickedBlock =  { (image) in
            /* get your image here */
            print("Got image!!!!")
            self.selectedImage = image
            self.imageEvent.setImage(image)
            self.stopLoadingIndicator()
            self.media_type = "image"
        }
        
        AttachmentHandler.shared.videoPickedBlock =  { (videoUrl) in
            /* get your video here */
            print("Got video!!!!")
            self.videoPath = videoUrl
            //print(self.videoPath)
            if let thumbnailImage = General.getThumbnailImage(forUrl:videoUrl as URL ) {
            self.videoEventImg.image = thumbnailImage
                self.media_type = "video"
            }
        }
    }

    
    func callEvntTypesApi(){
        if isConnectedToInternet(){
            createEventVM?.callGetTypessApi()
        }else{
            createEventVM?.delegate?.connectionFailed()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.placeHolderLbl.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tvDetails.text.isEmpty {
            self.placeHolderLbl.isHidden = false
        } else {
            self.placeHolderLbl.isHidden = true
        }
    }

    func setupCountriesMenu() {
        var names:[String] = []
        for model in createEventVM?.countriesArray ?? [] {
            names.append(model?.name ?? "")
        }
        if LanguageManager.shared.currentLanguage == .ar {
            countryDropDown.langNum = "1"
            countryDropDown.isTransform = true
        }else{
            countryDropDown.langNum = "2"
        }
        countryDropDown.dataSource = names
        countryDropDown.anchorView = btnCountry
        countryDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.selectedCountryId = self?.createEventVM?.countriesArray?[index]?.id
            self?.btnCountry.setTitle(names[index], for: .normal)
        }
    }
    

    
    @objc func SetSelectedAddressAction(notification: NSNotification)  {
        selectedAddress = notification.userInfo!["selectedAddress"] as? String
        selectLang = notification.userInfo!["selectedLang"] as? String
        selectLat = notification.userInfo!["selectedLat"] as? String
        print(selectedAddress ?? "")
       
        btnAddrress.setTitle(selectedAddress ?? "", for: .normal)
    }
    
    @IBAction func claenderAction(_ sender:UIButton){
        dismissKeyboard()
        CustomDateAndTimePicKer.instance.date = Date()
        CustomDateAndTimePicKer.instance.returnEventDate(max: Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date()) { [self] (selectedDate) in
            selectedDateAndTime = selectedDate
            btnDOB.setTitle(selectedDate, for: .normal)
        }
    }


   func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func countriesAction(_ sender:UIButton){
        dismissKeyboard()
        countryDropDown.show()
    }
    
    @IBAction func categoriesAction(_ sender:UIButton){
        dismissKeyboard()
        categoriesDropDown.show()
    }
    
    @IBAction func openMapVCTapped(){
        dismissKeyboard()
        let storyBoard : UIStoryboard = UIStoryboard(name: "TabBar", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "GoogleplacesVC") as! GoogleplacesVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    public func datePresentString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        let iso8601String = dateFormatter.string(from: date as Date)
        return iso8601String
    }
    
    func encodeVideo(at videoURL: URL, completionHandler: ((URL?, Error?) -> Void)?)  {
        let asset = AVAsset(url: videoURL) // video url from library
        let fileMgr = FileManager.default
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        let filePath = dirPaths[0].appendingPathComponent("Video_\(datePresentString()).mp4") //create new data in file manage .mp4
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        
        // remove file if already exits
        let fileManager = FileManager.default
        do {
            try? fileManager.removeItem(at: filePath)
            
        } catch {
            print("can't")
        }
        exportSession?.outputFileType = AVFileType.mp4
        exportSession?.metadata = asset.metadata
        exportSession?.outputURL = filePath
        
        exportSession?.exportAsynchronously {
            if exportSession?.status == .completed {
                
                print("AV export succeeded. \(filePath)") //AV export succeeded. file:///var/mobile/Containers/Data/Application/2E3A7C66-BA96-4FEE-8F76-B8206672BB03/Documents/Video_20181031_144026.mp4
                // outputUrl to post Audio on server
                print(exportSession?.error ?? "NO ERROR")
                DispatchQueue.main.async {[weak self] in
                    
                    completionHandler?(filePath, exportSession?.error)
                }
                
            } else if exportSession?.status == .cancelled {
                print("AV export cancelled.")
                completionHandler?(nil, nil)
                
            } else {
                print("Error is \(String(describing: exportSession?.error))")
            }
        }
    }

    //MARK: ----- addEventAction
    @IBAction func addEventAction(_ sender:UIButton){
        if tfEmail.text == "" || tfPhone.text == "" || selectedId == [] || selectedCountryId == nil || tfTitle.text == "" || tvDetails.text == "" || selectedAddress == nil || selectedDateAndTime == nil || (selectedImage == nil && videoPath == nil) {
            showErrorAlert(message: Constants.messages.msgFillEmptyFields)
        }else  if !tfEmail.text!.isValidEmail {
            showErrorAlert(message: "Please enter a valid email".localiz())
        }else if ((tfwebsite.text?.isValidUrl) != nil) != true {
            showErrorAlert(message: "invalide url")
        }else if ((tfTwitter.text?.isValidUrl) != nil) != true {
            showErrorAlert(message: "invalide twitter url")
        }else if ((tfInstagram.text?.isValidUrl) != nil) != true{
            showErrorAlert(message: "invalide insta url")
        }else{
            let parameters = ["creator":tfCreator.text!,
                              "lat":selectLat!,
                              "lng":selectLang!,
                              "website":tfwebsite.text!,
                              "location":selectedAddress!,
                              "facebook":tfTwitter.text!,
                              "title":tfTitle.text!,
                              "des":tvDetails.text!,
                              "event_type_id[]":selectedId,
                              "date_time":selectedDateAndTime!,
                              "media_type":media_type!,
                              "phone":tfPhone.text!,
                              "twitter":"",
                              "Instagram":tfInstagram.text!,
                              "email":tfEmail.text!,
                              "city_id":selectedCountryId!] as [String : Any]
            if videoPath != nil {
                print(videoPath!)
                DispatchQueue.main.async {
                    self.encodeVideo(at: self.videoPath! ) { (mp4Url, error) in
                        self.createEventVM?.createEventApi(parameters:parameters, image: nil, video: mp4Url!)
                    }
                }
            }else{
                self.createEventVM?.createEventApi(parameters:parameters, image: selectedImage, video: nil)
            }
        }
        }
    }


extension CreateEventVC:AuthNavigationDelegate{
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    func turAction() {
        
    }
}



extension CreateEventVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    
    @IBAction func uploadPhotoAction(_ sender:UIButton){
        dismissKeyboard()
//        if videoPath == nil {
            AttachmentHandler.shared.showAttachmentActionSheetForImage(vc:self )
//        }else
//        {
//            showErrorAlert(message:"You can only upload photo or video".localiz())
//        }
    }
    
    @IBAction func uploadVideoAction(_ sender:UIButton){
        dismissKeyboard()
//        if selectedImage == nil{
            AttachmentHandler.shared.showAttachmentActionSheetForVideo(vc:self )
//        }
//        else
//        {
//            showErrorAlert(message:"You can only upload photo or video".localiz())
//        }
//
    }
    
}

extension String{
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidUrl() -> Bool {
        let regex = "((http|https|ftp)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

}
