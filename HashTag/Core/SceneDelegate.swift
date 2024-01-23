//
//  SceneDelegate.swift
//  HashTag
//
//  Created by Mohamed Shendy on 02/02/2023.
//

import UIKit
import FacebookCore
//import TwitterKit
import Swifter
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
        if let openURLContext = URLContexts.first{
          let url = openURLContext.url
          let options: [AnyHashable : Any] = [
            UIApplication.OpenURLOptionsKey.annotation : openURLContext.options.annotation,
            UIApplication.OpenURLOptionsKey.sourceApplication : openURLContext.options.sourceApplication as Any,
            UIApplication.OpenURLOptionsKey.openInPlace: openURLContext.options.openInPlace
          ]
            guard let context = URLContexts.first else { return }
            let callbackUrl = URL(string:Constants.TwitterConstants.callbackUrl)!
            Swifter.handleOpenURL(context.url, callbackURL: callbackUrl)
        }
    }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let navigationController = UINavigationController(rootViewController: SplashViewController() )
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}

