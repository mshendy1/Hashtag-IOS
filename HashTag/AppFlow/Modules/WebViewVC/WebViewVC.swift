//
//  WebViewVC.swift
//  HashTag
//
//  Created by Trend-HuB on 09/08/1444 AH.
//

import UIKit
import WebKit
import GoogleMaps
import GooglePlaces

class WebViewVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var header: AuthNavigation!
    var selected_latitude:Double!
    var selected_longitude:Double!

    var url:String!
    var twitter:Bool?
    var text:String!
    var type:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
            if type == "privacy" {
                header.lblTitle.text = Constants.PagesTitles.privacyTitle
            }else if type == "terms"{
                header.lblTitle.text = Constants.PagesTitles.termsTitle
            }else{
                header.lblTitle.text = Constants.PagesTitles.postDetailsTitle
            }

        header.img.isHidden = true
        header.switchNotificattion.isHidden = true
        header.delegate = self
       
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        if twitter == true{
            let twitterUrl = URL(string:"https://twitter.com/search?q=\(text ?? "")")
            let myRequest = URLRequest(url: twitterUrl!)
            webView.load(myRequest)
        }else{
            let myURL = URL(string:url)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        guard let redirectURL = (navigationAction.request.url) else {
            decisionHandler(.cancel)
            return
        }
        if (redirectURL.absoluteString.contains("tel:") ) {
            UIApplication.shared.open(redirectURL, options: [:], completionHandler: nil)
        }
        
        if (redirectURL.absoluteString.contains("whatsapp") ) {
            UIApplication.shared.open(redirectURL, options: [:], completionHandler: nil)
        }
        
        decisionHandler(.allow)
    }
    
    
}
extension WebViewVC: WKUIDelegate {

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        guard let url = navigationAction.request.url else {
            return nil
        }
        
        guard let targetFrame = navigationAction.targetFrame, targetFrame.isMainFrame else {
            webView.load(URLRequest(url: url))
            return nil
        }
        return nil
    }
}

extension WebViewVC:AuthNavigationDelegate{
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func turAction() {
        
    }
    
    
}



