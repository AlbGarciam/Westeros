//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 12/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate: AnyObject {
    func seasonListViewController(_ vc: SeasonListViewController, didRequestedToPresent season: Season)
}

class SeasonListViewController: UIViewController {
    //MARK: outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    //MARK: Properties
    let seasons: SeasonList
    weak var delegate: SeasonListViewControllerDelegate?
    
    init(seasons: SeasonList) {
        self.seasons = seasons
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SeasonListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let season = seasons[indexPath.row]
        let cellId = "SeasonCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ??
                    UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        cell.textLabel?.text = season.title
        cell.detailTextLabel?.text = "\(season.releaseDate)"
        return cell
    }
}

extension SeasonListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = seasons[indexPath.row]
        // Exercise 6
        /*
         * navigationController?.pushViewController(SeasonDetailViewController(model: season), animated: true)
         */
        
        
        delegate?.seasonListViewController(self, didRequestedToPresent: season)
        // Notify info via notification
        NotificationCenter.default.post(name: NSNotification.Name.seasonDidChanged,
                                        object: self,
                                        userInfo: [NotificationKeys.SeasonDidChanged: season])
        
//        Only for split view for iphone. This doesn't apply to this app because when we are on iphone we will make a push.
//        And it is not correct to have this navigation logic inside a tableview. Instead of that, notify the delegate to
//        perform the navigation
//        if let detailViewController = delegate as? UIViewController,
//            let detailNavigationController = detailViewController.navigationController {
//            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
//        }
    }
}
