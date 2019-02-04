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
        let starkSigil = Sigil(image: UIImage(named:"codeIsComing") ?? UIImage(), description: "Lobo huargo")
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
        
        let lannisterSigil = Sigil(image: UIImage(named: "lannister") ?? UIImage(), description: "León rampante")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([HouseDetailsViewController(model: starkHouse),
                                             HouseDetailsViewController(model: lannisterHouse)],
                                            animated: true)
        
        let screen = UIScreen.main.bounds
        window = UIWindow(frame: screen)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        window?.rootViewController = tabBarController
        
        return true
    }

}

