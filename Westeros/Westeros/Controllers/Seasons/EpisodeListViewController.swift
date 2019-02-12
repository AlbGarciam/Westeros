//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 12/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    //MARK: Properties
    let episodes: [Episode]
    
    init(episodes: [Episode]) {
        self.episodes = episodes
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EpisodeListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        
        let cellId = "EpisodeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        cell.textLabel?.text = episode.title
        cell.detailTextLabel?.text = episode.releaseDate.description
        
        return cell
    }
}

extension EpisodeListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        // navigationController?.pushViewController(SeasonDetailViewController(model: season), animated: true)
    }
}
