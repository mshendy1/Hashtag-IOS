//
//  IntroViewController.swift
//  HashTag
//
//  Created by Mohamed Shendy on 02/02/2023.
//

import UIKit
import LanguageManager_iOS

class IntroVC: UIViewController {
    @IBOutlet weak var header:IntroNavigation!
    var introVM:IntroViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        header.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        introVM = IntroViewModel(delegate: self)
    }
    func setEnglishLang() {
        var lan = "en"
        var lang : Languages = .en
        UIView.appearance().semanticContentAttribute =  .forceLeftToRight
        lang = .en
        UserDefaults.standard.set([lan], forKey: "AppleLanguages")
        UserDefaults.standard.set(lan, forKey: "Applanguage")
        UserDefaults.standard.synchronize()
        LanguageManager.shared.setLanguage(language: lang)
    }

    func setArabicLang() {
        var lan = "ar"
        var lang : Languages = .ar
        UIView.appearance().semanticContentAttribute =  .forceLeftToRight
        lang = .ar
        
        UserDefaults.standard.set([lan], forKey: "AppleLanguages")
        UserDefaults.standard.set(lan, forKey: "Applanguage")
        UserDefaults.standard.synchronize()
        LanguageManager.shared.setLanguage(language: lang)
    }
    
    func moveToLogin(){
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToRegister(){
        let vc = RegisterVC()
        vc.fromLogin = false
        navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func loginTapped(){
        moveToLogin()
    }
    @IBAction func registerTapped(){
        moveToRegister()
    }


}

extension IntroVC:IntroNavigationDelegate{
    func skip() {
        visitorTapped()
    }
    func visitorTapped(){
        let uuid = UserData.shared.deviceId ?? ""
        guard let token = UserDefaults.standard.value(forKey: "mobileToken")as? String else { return}
        callGuestUserApi(fcmToken:token,deviceId:uuid)
    }
    func callGuestUserApi(fcmToken: String, deviceId: String){
        if isConnectedToInternet(){
            introVM.guestUserStoreApi(firebaseToken: fcmToken, deviceId: deviceId)
        }else{
            introVM.delegate?.connectionFailed()
        }
    }
    
//    func selectLanguage() {
//        if LanguageManager.shared.isRightToLeft{
//            setEnglishLang()
//        }
//       else
//        {
//           setArabicLang()
//       }
//
//
//        let vc = SplashViewController()
//        let nav = UINavigationController.init(rootViewController: vc)
//
//        let keyWindow = UIApplication.shared.connectedScenes
//            .filter({$0.activationState == .foregroundActive})
//            .map({$0 as? UIWindowScene})
//            .compactMap({$0})
//            .first?.windows
//            .filter({$0.isKeyWindow}).first
//
//        keyWindow?.endEditing(true)
//
//       keyWindow?.rootViewController = nav
//    }
}

extension IntroVC:IntroViewModelDelegate{
    func showLoading() {
        startLoadingIndicator()
    }
    func killLoading() {
        stopLoadingIndicator()
    }
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func showError(error:String){
        showErrorNativeAlert(message: error)
    }
    
    func skipToHome(){
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SSCustomTabBarViewController") as! SSCustomTabBarViewController
        let customTabBar = vc.tabBar as? SSCustomTabBar
        customTabBar?.customeLayout()
        if LanguageManager.shared.isRightToLeft {
            vc.lang = "ar"
        }
        General.sharedInstance.mainNav = self.navigationController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
