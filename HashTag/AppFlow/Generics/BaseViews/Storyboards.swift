//
//  Storyboards.swift
//  HashTag
//
//  Created by Mohamed Shendy on 06/02/2023.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    case forgetPassword = "ForgetPassword"
    case verificaionCode = "VerificationCodeVC"
    case news = "NewsVC"
    case trens = "TrendsVC"
    case events = "EventsVC"
    case polls = "PollsVC"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        }
    
    /**
     This function takes class name as argument and returns it’s instance.
     - parameter viewControllerClass: Class of UIViewController
     - Returns: Class instance.
     */
    func viewController< T: UIViewController>(viewControllerClass: T.Type) -> T? {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as? T
    }
    /**
     This function takes class name as argument and returns it’s instance.
     - parameter tabBarControllerClass: Class of UITabBarController
     - Returns: Class instance.
     */
    func tabBarController< T: UITabBarController>(viewControllerClass: T.Type) -> T? {
        let storyboardID = (viewControllerClass as UITabBarController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as? T
    }
}

extension UIViewController {
    class var storyboardID: String {
        return String(describing: self)
    }
    /**
     To get instance from the needed ViewControllers
     - parameter appStoryboard: Storyboard that the needed ViewControllers init
     - Returns: Self refers to the type of the current "thing"
     */
    static func instantiateFromAppStoryboard(_ appStoryboard: AppStoryboard) -> Self? {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
extension UITabBarController {
    /**
     To get instance from the needed ViewControllers
     - parameter appStoryboard: Storyboard that the needed UITabBarController init
     - Returns: Self refers to the type of the current "thing"
     */
    static func instantiateTabFromAppStoryboard(_ appStoryboard: AppStoryboard) -> Self? {
        return appStoryboard.tabBarController(viewControllerClass: self)
    }
}
