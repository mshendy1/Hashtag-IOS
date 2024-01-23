//
//  AppDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 02/02/2023.
//

import UIKit
import CoreData
import LanguageManager_iOS
import IQKeyboardManager
import netfox
import AuthenticationServices
import GooglePlaces
import GoogleMaps
import FacebookCore
import FBSDKLoginKit
import FirebaseCore
import FirebaseAuth
import FirebaseMessaging
import PKHUD
import GoogleSignIn
import Swifter
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ =  UIApplication.shared.delegate as! AppDelegate
        
        NFX.sharedInstance().start()
        
        // MARK:- Google Maps Keys
        GMSServices.provideAPIKey(Constants.googlsMapKeys.provideAPIKey)
        GMSPlacesClient.provideAPIKey(Constants.googlsMapKeys.provideAPIKey)
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        UserData.shared.deviceId = deviceID
        setArabicLang()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().toolbarTintColor = #colorLiteral(red: 0.003921568627, green: 0.05882352941, blue: 0.02745098039, alpha: 1)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        CheckUpdate.shared.showUpdate(withConfirmation: true)
     
        // MARK: - Auth With Apple
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("authorized login with apple")
                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                DispatchQueue.main.async {
                    self.window?.rootViewController? = LoginVC()
                }
            default:
                break
            }
        }
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID

        self.registerForPushNotifications(application:application)
        DispatchQueue.main.async {
            self.handleNotificationWhenAppIsKilled(launchOptions)
        }
        return true
    }
    
    
    func handleNotificationWhenAppIsKilled(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // Check if launched from the remote notification and application is Killed by user
         let notificationOption = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification]
            if let notification = notificationOption as? [String: AnyObject],
             let aps = notification["aps"] as? [String: AnyObject],
                  let alert = aps["alert"] as? [String : AnyObject]  {
                  // let titleOfPush = alert["title"] as? String
                      //let type = notification["type"] as! String
                      let id = notification["id"] as! String
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .init("Notification_post_Details"), object: nil,userInfo:["id":id])
                }
        }
            
    }

    func application(
        _ app: UIApplication, open url: URL,options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
            ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
            let handel =  GIDSignIn.sharedInstance().handle(url)
            let callbackUrl = URL(string: Constants.TwitterConstants.callbackUrl)!
            let twitter =  Swifter.handleOpenURL(url, callbackURL: callbackUrl)
            return handel||twitter
        }
    
    func setEnglishLang() {
        let lan = "en"
        var lang : Languages = .en
        UIView.appearance().semanticContentAttribute =  .forceLeftToRight
        lang = .en
        UserDefaults.standard.set([lan], forKey: "AppleLanguages")
        UserDefaults.standard.set(lan, forKey: "Applanguage")
        UserDefaults.standard.synchronize()
        LanguageManager.shared.setLanguage(language: lang)
    }
    
    func setArabicLang() {
        let lan = "ar"
        var lang : Languages = .ar
        UIView.appearance().semanticContentAttribute =  .forceLeftToRight
        lang = .ar
        UserDefaults.standard.set([lan], forKey: "AppleLanguages")
        UserDefaults.standard.set(lan, forKey: "Applanguage")
        UserDefaults.standard.synchronize()
        LanguageManager.shared.setLanguage(language: lang)
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HashTag")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS  devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
//        print(userInfo)
        UserDefaults.standard.setUserInfo(value: userInfo)
        if let type = userInfo["type"] as? String {
            print("recive notification with type: \(type)")
//            let message = userInfo["body"] as? String
//            let id = userInfo["id"] as? String
        }
//        print(userInfo)
        return [[.alert, .sound]]
    }
    
   class func HandelPushWhenAppOpendWith(id:String,type:String,title:String,body:String) {
        print(type)
        switch type{
        case "news":
            NotificationCenter.default.post(name: .init("Notification_post_Details"), object: nil,userInfo:["id":id])
        case "events":
            NotificationCenter.default.post(name: .init("Notification_event_Details"), object: nil,userInfo: ["id":id])
        case "Survay":
            NotificationCenter.default.post(name: .init("Notification_survay_Details"), object: nil,userInfo: ["id":id])
        default:
            print("Notification Another type")
        }
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
       
        let application = UIApplication.shared
        let userInfo = response.notification.request.content.userInfo
        UserDefaults.standard.setUserInfo(value: userInfo)
        // go to home
        switch application.applicationState {
        case .active,.inactive,.background :
            openHomeVC()
            completionHandler()
        default:
            openHomeVC()
            completionHandler()
        }
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

extension AppDelegate {
    
    func registerForPushNotifications(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().delegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }

    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("APNs token retrieved: \(token)")
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.newData)
    }

    func application(_ application: UIApplication,performFetchWithCompletionHandler completionHandler:
                     @escaping (UIBackgroundFetchResult) -> Void) {
        UIViewController().viewWillAppear(true)
    }
}

// [END ios_10_message_handling]
extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(String(describing: fcmToken))")
          let def = UserDefaults.standard
          def.setValue(fcmToken, forKey: "mobileToken")
          def.synchronize()
        let dataDict: [String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"),object: nil,userInfo: dataDict)
      }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
        let def = UserDefaults.standard
        def.setValue(fcmToken, forKey: "mobileToken")
        def.synchronize()
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )

    }

}
