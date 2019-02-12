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
        title = season.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncWithModel()
    }
    
    private func syncWithModel() {
        seasonTitle.text = "Season \(season.title)"
        releaseDate.text = "Released on: \(season.releaseDate)"
        numberOfEpisodes.text = "Number of episodes \(season.numberOfEpisodes)"
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didRequestedToPresent season: Season) {
        self.season = season
        syncWithModel()
    }
}
