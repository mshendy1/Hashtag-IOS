//
//  SplashViewController.swift
//  HashTag
//
//  Created by Mohamed Shendy on 02/02/2023.
//

import UIKit
import AVKit
import LanguageManager_iOS
import Lottie

class SplashViewController: UIViewController{

    private var animationView: LottieAnimationView?
    var notifiactionVM:NotificationViewModel?
    @IBOutlet weak var img:UIImageView!
    var splashVM:SplashViewModel!
    var userData = UserData.shared.userDetails
    var fcmToken = ""
   
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden =  true
        splashVM = SplashViewModel(delegate: self)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: FontManager.fontWithSize(size: 18, style: HashTagFontStyle.medium)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: FontManager.fontWithSize(size: 14, style: HashTagFontStyle.regular)], for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshFCMToken), name: .init("FCMToken"), object: nil)
        handelLottie()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {}
    
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
     }
   
    @objc func refreshFCMToken(notification: NSNotification)  {
        fcmToken = (notification.userInfo!["token"] as? String)!
        let userId = userData?.id
        if userId != nil {
            splashVM?.callRefreshFCMTokenApi(id: userId ?? 0, fcmToken: fcmToken)
        }
    }
    
    private func handelLottie(){
        animationView = .init(name: "SplachIntro")
        animationView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        animationView!.clipsToBounds = true
        animationView?.backgroundColor = Colors.PrimaryColor
          view.addSubview(animationView!)
        self.animationView!.play(completion: { finished in
            self.checkIfUserLoggedIn()
        })
    }
 
    
    func checkIfUserLoggedIn(){
      
        if UserDefaults.standard.isGuest(){
            openHomeVC()
        }else
        if UserDefaults.standard.isLoggedIn(){
            openHomeVC()
        }else{
            openLoginVC()
        }
    }
    
    func openLoginVC(){
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        keyWindow?.endEditing(true)
            let vc = IntroVC()
            let nav = UINavigationController(rootViewController: vc)
            keyWindow?.rootViewController = nav
    }
    
    
    func openHomeVC(){
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
             keyWindow?.endEditing(true)
           
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SSCustomTabBarViewController") as! SSCustomTabBarViewController
            let customTabBar = vc.tabBar as? SSCustomTabBar
            customTabBar?.customeLayout()
             if LanguageManager.shared.isRightToLeft{
                vc.lang = "ar"
            }
            let nav = UINavigationController(rootViewController: vc)
            General.sharedInstance.mainNav = nav
            keyWindow?.rootViewController = nav
    }

}




extension SplashViewController:SplashViewModelDelegate{
    func showLoading() {
    }
    
    func killLoading() {
    }
    
    func connectionFailed() {
        showNoInternetAlert()
    }
    
    func showError(error:String){
        showErrorAlert(message: error)
    }

    
    func refreshSuccessfully() {
        
    }
    
    
    
    
}
