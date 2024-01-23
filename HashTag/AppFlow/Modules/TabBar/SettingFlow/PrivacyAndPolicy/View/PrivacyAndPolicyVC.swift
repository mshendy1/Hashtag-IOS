//
//  PrivacyAndPolicyVC.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import UIKit

class PrivacyAndPolicyVC: UIViewController {
    @IBOutlet weak var header:AuthNavigation!
    @IBOutlet weak var txtView:UITextView!
    var PrivacyVM:PrivacyViewModel?
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        PrivacyVM = PrivacyViewModel(delegate: self)
        PrivacyVM?.delegate?.setHeader()
        callApi()
    }

    func callApi(){
        if isConnectedToInternet() {
            if type == "privacy" {
        PrivacyVM?.getPrivacyAPI()
            }else if type == "terms"{
        PrivacyVM?.getTermsAPI()
            }
        }else{
           showNoInternetAlert()
        }
    }
    
}

extension PrivacyAndPolicyVC:AuthNavigationDelegate{
    func backAction() {
    self.navigationController?.popViewController(animated: true)
}

    func turAction() {}
}




extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
