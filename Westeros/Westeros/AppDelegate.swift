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
    
    /*
     *  These 4 controller cannot exists at the same time, if it is on iphone
     *  we won't have *InNav controllers and viceversa on ipad
     */
    //MARK: For iPhone
    var houseDetail: HouseDetailsViewController?
    var seasonDetail: SeasonDetailViewController?
    
    //MARK: For iPad
    var houseDetailInNav: UINavigationController?
    var seasonDetailInNav: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //MARK: Houses
        let houses = Repository.local.houses
        let houseList = HouseListViewController(model: houses)
        let initialHouse = houseList.lastSelectedHouse() ?? houses.first!
        let houseDetail = HouseDetailsViewController(model: initialHouse)
        
        //MARK:Seasons
        let seasons = Repository.local.seasons
        let seasonsList = SeasonListViewController(seasons: seasons)
        let seasonDetail = SeasonDetailViewController(model: seasons.first!)
        
        //MARK: TabBar
        let tabBar = UITabBarController()
        tabBar.viewControllers = [houseList.wrapInNavigationController(),
                                  seasonsList.wrapInNavigationController()]
        
        //MARK: Split view
        let splitView = UISplitViewController()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            tabBar.delegate = self
            seasonsList.delegate = seasonDetail
            houseList.delegate = houseDetail
            seasonDetailInNav = seasonDetail.wrapInNavigationController()
            houseDetailInNav = houseDetail.wrapInNavigationController()
            splitView.viewControllers = [tabBar, houseDetailInNav!]
        
        case .phone:
            self.seasonDetail = seasonDetail
            self.houseDetail = houseDetail
            seasonsList.delegate = self
            houseList.delegate = self
            splitView.viewControllers = [tabBar, UIViewController()]
            break
        default:
            break
        }
        
        
        //MARK: SplitView
        splitView.preferredDisplayMode = UISplitViewController.DisplayMode.allVisible
        
        houseDetailInNav?.navigationItem.leftBarButtonItem = splitView.displayModeButtonItem
        houseDetailInNav?.navigationItem.leftItemsSupplementBackButton = true
        
        seasonDetailInNav?.navigationItem.leftBarButtonItem = splitView.displayModeButtonItem
        seasonDetailInNav?.navigationItem.leftItemsSupplementBackButton = true
        
        let screen = UIScreen.main.bounds
        window = UIWindow(frame: screen)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        window?.rootViewController = splitView
        
        return true
    }

}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        /*
         * If the following condition is not applied, we cannot do anything. The requirements are:
         *      1. TabBar must be a child of a UISplitViewController
         *      2. Selected ViewController must be a UINavigationController
         *      3. The root of selected UINavigationController, should exists
         */
        guard let splitView = tabBarController.parent as? UISplitViewController,
              let nav = (viewController as? UINavigationController),
              let rootView = nav.viewControllers.first else { return }
        /*
         * Once rules are passed, we need to check which Controller is, to do that we will check rootView class
         */
        if rootView is HouseListViewController, let houseDetail = houseDetailInNav{
            splitView.showDetailViewController(houseDetail, sender: nil)
        } else if rootView is SeasonListViewController, let seasonDetail = seasonDetailInNav {
            splitView.showDetailViewController(seasonDetail, sender: nil)
        }
    }
}

extension AppDelegate: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didRequestedToPresent house: House) {
        guard let detail = houseDetail else { return }
        detail.updateHouse(with: house)
        vc.navigationController?.pushViewController(detail, animated: true)
    }
}

extension AppDelegate: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didRequestedToPresent season: Season) {
        guard let detail = seasonDetail else { return }
        detail.updateSeason(with: season)
        vc.navigationController?.pushViewController(detail, animated: true)
    }
}
