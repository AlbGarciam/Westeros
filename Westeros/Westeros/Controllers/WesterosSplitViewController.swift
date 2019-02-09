//
//  WesterosSplitViewController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 09/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

class WesterosSplitViewController: UISplitViewController {
    
    //MARK: Initializers
    init(houses: HouseList) {
        super.init(nibName: nil, bundle: nil)
        let master = HouseListViewController(model: houses)
        let detail = getInitialDetailVC(houses: houses) ?? UIViewController()
        master.delegate = self
        delegate = self
        viewControllers = [master.wrapInNavigationController(), detail.wrapInNavigationController()]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private methods
    private func getInitialDetailVC(houses: HouseList) -> UIViewController? {
        guard let house = houses.first else { return nil }
        return HouseDetailsViewController(model: house)
    }
    
}

extension WesterosSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension WesterosSplitViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didRequestedToPresent house: House) {
        let newDetailVC = HouseDetailsViewController(model: house)
        showDetailViewController(newDetailVC.wrapInNavigationController(), sender: self)
    }
}
