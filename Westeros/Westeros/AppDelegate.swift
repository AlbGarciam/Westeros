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
        //MARK: Houses
        let houses = Repository.local.houses
        let houseList = HouseListViewController(model: houses)
        
        let initialHouse = houseList.lastSelectedHouse() ?? houses.first!
        let houseDetail = HouseDetailsViewController(model: initialHouse)
        houseDetail.navigationItem.leftItemsSupplementBackButton = true
        houseList.delegate = houseDetail
        
        let housesNavigation = houseList.wrapInNavigationController()
        
        //MARK:Seasons
        let seasons = Repository.local.seasons
        let seasonsList = SeasonListViewController(seasons: seasons)
        let seasonDetails = SeasonDetailViewController(model: seasons.first!)
        seasonsList.delegate = seasonDetails
        
        let seasonsNavigation = seasonsList.wrapInNavigationController()
        
        
        
        
        
        
        
        
        //MARK:SplitView
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [houseList.wrapInNavigationController(),
                                              houseDetail.wrapInNavigationController()]
        houseDetail.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        
        
        let screen = UIScreen.main.bounds
        window = UIWindow(frame: screen)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        window?.rootViewController = splitViewController
        
        return true
    }

}

