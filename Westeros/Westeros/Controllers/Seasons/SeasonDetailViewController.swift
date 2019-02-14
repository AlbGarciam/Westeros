//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 12/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    @IBOutlet weak var seasonTitle: UILabel! {
        didSet {
            seasonTitle.font = .boldSystemFont(ofSize: 20)
            seasonTitle.textAlignment = .center
        }
    }
    @IBOutlet weak var releaseDate: UILabel! {
        didSet {
            releaseDate.font = .boldSystemFont(ofSize: 18)
            releaseDate.textAlignment = .center
        }
    }
    @IBOutlet weak var numberOfEpisodes: UILabel! {
        didSet {
            numberOfEpisodes.font = .boldSystemFont(ofSize: 18)
            numberOfEpisodes.textAlignment = .center
        }
    }
    
    //MARK: Properties
    private(set) var season: Season
    
    init(model: Season) {
        season = model
        // Nil nibname -> tries to load a .xib with the same name than class
        // Nil bundle -> Uses the same as target
        //                          It will be accessible from all bundles
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
    }
    
    //MARK: Target methods
    func updateSeason(with season: Season) {
        self.season = season
        syncModelWithView()
    }
    
    //MARK: Private methods
    
    private func setupUI() {
        let episodes = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        navigationItem.rightBarButtonItems = [episodes]
    }
    
    @objc private func displayEpisodes() {
        navigationController?.pushViewController(EpisodeListViewController(episodes: season.sortedEpisodes), animated: true)
    }
    
    //MARK: - Sync method
    
    /// Updates the UI with the model. If outlets are not loaded it won't do anything because that
    /// means that view is not loaded and it will be sync again during viewWillAppear
    private func syncModelWithView() {
        seasonTitle?.text = season.title
        releaseDate?.text = "Released on: \(season.releaseDate)"
        numberOfEpisodes?.text = "Number of episodes \(season.numberOfEpisodes)"
        title = season.title
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didRequestedToPresent season: Season) {
        self.season = season
        syncModelWithView()
    }
}
