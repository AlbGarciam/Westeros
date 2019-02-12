//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 07/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

protocol HouseListViewControllerDelegate: AnyObject {
    func houseListViewController(_ vc: HouseListViewController, didRequestedToPresent house: House)
}

class HouseListViewController: UITableViewController {
    //MARK: Properties
    let model: HouseList
    weak var delegate: HouseListViewControllerDelegate?
    
    init(model: HouseList) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let house = model[indexPath.row]
        
        let cellId = "HouseCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = house.name
        cell.imageView?.image = house.sigil.image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let house = model[indexPath.row]
        delegate?.houseListViewController(self, didRequestedToPresent: house)
        // Notify info via notification
        NotificationCenter.default.post(name: NSNotification.Name.houseDidChanged,
                                        object: self,
                                        userInfo: [NotificationKeys.HouseDidChanged: house])
        // Only for split view
        if let detailViewController = delegate as? UIViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
        
        saveLastSelectedHouse(at: indexPath.row)
    }
}

extension HouseListViewController {
    func saveLastSelectedHouse(at index: Int) {
        // Do not include complex objects
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: UserDefaultsKeyNames.lastSelectedHouse.rawValue)
        userDefaults.synchronize() // Will be deprecated in future
    }
    
    func lastSelectedHouse() -> House? {
        let userDefaults = UserDefaults.standard
        let index = userDefaults.integer(forKey: UserDefaultsKeyNames.lastSelectedHouse.rawValue)
        return house(at: index)
    }
    
    func house(at index: Int) -> House? {
        guard index > 0 && index < model.count else { return nil }
        return model[index]
    }
}
