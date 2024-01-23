//
//  General.swift
//  medexa
//
//  Created by Mohamed Shendy on 1/20/22.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

internal class General: NSObject {
   
    static let sharedInstance = General()
    var fromLoginSheet:Bool?
    var Unselecteimgs = ["news","google","youtube"]
    var selecteimgs = ["selectNews","selectGoogle","selectYoutube"]
    var trendTitles = ["News","Google","Youtube"]
    var settingImgs = ["user","myEvents","contactUs","ques","privacy","terms","blockUser"]
    var settingTitles = ["Profile".localiz(),"Categories".localiz(),"My Events".localiz(),"Contact us".localiz(),"Common questions".localiz(),"policy and privacy".localiz(),"Terms".localiz(),"blockUser".localiz()]
    var genderTitles = ["male".localiz(),"female".localiz(),]
    var gendeImgs = ["man","woman"]
    var selectecDateOfBirth = ""
    var selectecGender = ""
    var selectecGenderImg = ""
    var selectedCategories:[CategoryModel] = []
    var selectedTags:[TagsModel] = []
    var selectedCatId : [Int] = []
    var selectedTagId : [Int] = []
    var selectedTypesId : [Int] = []
    var socialLoginType = ""
    var selectedTypes:[TypesModel?] = []
    var selectedCountriesNews:[CountriesModel?] = []
    var selectedCategoriesNews:[CategoryModel] = []
    var selectedCatIdNews : [Int] = []    
    var selectedCountryIdNews : [Int] = []
    //MARK: - home TableCell Height
    var eventsTableCellHeight = 213.0
    var newsPostsTableCellHeight = 340.0
    var surveysTableCellHeight = 229.0
    var twitterTableCellHeight = 76.0
    var googleNewsTableCellHeight = 212.0
    var youtubeTableCellHeight = 361.0
    var NewsVideoTablecellHeihht = 341.0
    var calenderEventCellHeight = 72.0
    var isEditting = false
    var isAPNS:Bool?
    var apnsId = ""
    var apnsType = ""
    var userName = ""
    var userEmail = ""
    var userImg = ""
    var mainNav:UINavigationController?
    var notificationCount:String?
    var privacyLink = "https://hashksa.co/privacy-and-policy"
    var termsLink = "https://hashksa.co/terms-of-use"


    private override init(){
           super.init()
       }
    class func CurrentDeviceLanguage() -> String {
        let preferredIdentifier = Locale.preferredLanguages.first
        if preferredIdentifier!.range(of:"en") != nil {
            print("Device lang en")
            return "en"
        }else
            if preferredIdentifier!.range(of:"ar") != nil {
                print("Device lang ar")
                return "ar"
            }else {
                print("Device lang en")
                return "en"
        }
    }
    
    class func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    class func changeArabicNumbers(arabicNum: String) -> String {
        var newPass = arabicNum
        newPass = newPass.replacingOccurrences(of: "٠", with: "0")
        newPass = newPass.replacingOccurrences(of: "١", with: "1")
        newPass = newPass.replacingOccurrences(of: "٢", with: "2")
        newPass = newPass.replacingOccurrences(of: "٣", with: "3")
        newPass = newPass.replacingOccurrences(of: "٤", with: "4")
        newPass = newPass.replacingOccurrences(of: "٥", with: "5")
        newPass = newPass.replacingOccurrences(of: "٦", with: "6")
        newPass = newPass.replacingOccurrences(of: "٧", with: "7")
        newPass = newPass.replacingOccurrences(of: "٨", with: "8")
        newPass = newPass.replacingOccurrences(of: "٩", with: "9")
        return newPass
    }
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width:width, height:CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.text = text
            
            label.sizeToFit()
            return label.frame.height
        }
    class func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

    class func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
       
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            if let output = filter.outputImage {
                return UIImage(ciImage: output)
            }

        }
       
        return nil
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor
    {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    class func compressImage(image:UIImage) -> Data {
        // Reducing file size to a 10th
        
        var actualHeight : CGFloat = image.size.height
        var actualWidth : CGFloat = image.size.width
        let maxHeight : CGFloat = 1136.0
        let maxWidth : CGFloat = 640.0
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        var compressionQuality : CGFloat = 0.5
        
        if (actualHeight > maxHeight || actualWidth > maxWidth){
            if(imgRatio < maxRatio){
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio){
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else{
                actualHeight = maxHeight;
                actualWidth = maxWidth;
                compressionQuality = 1;
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        
        UIGraphicsBeginImageContext(rect.size);
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext();
        let imageData = img!.jpegData(compressionQuality: compressionQuality)
        UIGraphicsEndImageContext();
        
        return imageData!
    }
    

    
    
        
}
