//
//  AppStoryBoard.swift
//  medexa
//
//  Created by Mohamed Shendy on 19/11/21.
//  Copyright © 2021 Mohamed Shendyaber. All rights reserved.
//


import UIKit

//enum AppStoryboard : String {
//    
//    case Main
//    case TabBar
//    case Login
//
//    var instance : UIStoryboard {
//        
//        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
//    }
//    
//    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
//        
//        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
//        
//        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
//            
//            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
//        }
//        
//        return scene
//    }
//    
//    func initialViewController() -> UIViewController? {
//        
//        return instance.instantiateInitialViewController()
//    }
//}

//extension UIViewController {
//    
//    // Not using static as it wont be possible to override to provide custom storyboardID then
//    
//    class var storyboardID : String {
//        
//        return "\(self)"
//    }
//    
//    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
//        
//        return appStoryboard.viewController(viewControllerClass: self)
//    }
//}
