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
        
        let houses = Repository.local.houses
        let splitViewController = UISplitViewController()
        let houseList = HouseListViewController(model: houses)
        let initialHouse = houseList.lastSelectedHouse() ?? houses.first!
        
        let houseDetail = HouseDetailsViewController(model: initialHouse)
        
        splitViewController.viewControllers = [houseList.wrapInNavigationController(),
                                              houseDetail.wrapInNavigationController()]
        
        houseDetail.navigationItem.leftItemsSupplementBackButton = true
        houseDetail.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        houseList.delegate = houseDetail
        
        let screen = UIScreen.main.bounds
        window = UIWindow(frame: screen)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        window?.rootViewController = splitViewController
        
        return true
    }

}

