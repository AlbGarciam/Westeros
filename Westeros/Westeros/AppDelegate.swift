//
//  AppDelegate.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 31/01/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controllers : [UIViewController] = Repository.local.houses.map {
            HouseDetailsViewController(model: $0).wrapInNavigationController()
        }
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(controllers, animated: true)
        
        let screen = UIScreen.main.bounds
        window = UIWindow(frame: screen)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        window?.rootViewController = tabBarController
        
        return true
    }

}

