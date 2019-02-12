//
//  EpisodeDetailsViewController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 12/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {

    @IBOutlet weak var episodeTitle: UILabel! {
        didSet {
            episodeTitle.font = .boldSystemFont(ofSize: 20)
            episodeTitle.textAlignment = .center
        }
    }
    @IBOutlet weak var releaseDate: UILabel! {
        didSet {
            releaseDate.font = .boldSystemFont(ofSize: 18)
            releaseDate.textAlignment = .center
        }
    }
    
    //MARK: Properties
    private(set) var episode: Episode
    
    init(model: Episode) {
        episode = model
        // Nil nibname -> tries to load a .xib with the same name than class
        // Nil bundle -> Uses the same as target
        //                          It will be accessible from all bundles
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = episode.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncWithModel()
    }
    
    private func syncWithModel() {
        episodeTitle.text = "Episode \(episode.title)"
        releaseDate.text = "Released on: \(episode.releaseDate)"
    }
}
