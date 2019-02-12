//
//  LocalFactory+SeasonsFactory.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 12/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import Foundation

typealias SeasonList = [Season]
typealias SeasonFilter = (Season) -> Bool

protocol SeasonFactory {
    var seasons: SeasonList { get } // Read-only variable
//    func house(named name: String) -> House?
    func seasons(filteredBy filter: SeasonFilter) -> SeasonList
}

extension LocalFactory: SeasonFactory {
    var seasons: SeasonList {
        let numberOfSeasons = 7
        var seasons = SeasonList()
        for seasonNumber in 0..<numberOfSeasons {
            let season = Season(title: "Season \(seasonNumber+1)", releaseDate: Date()+TimeInterval(seasonNumber*300))
            for episodeNumber in 1 ... Int.random(in: 3..<15) {
                let episode = Episode(title: "S\(seasonNumber+1)E\(episodeNumber)",
                    releaseDate: season.releaseDate+TimeInterval((episodeNumber-1)*10),
                    season: season)
                season.add(episode: episode)
            }
            seasons.append(season)
        }
        return seasons.sorted()
    }
    
    func seasons(filteredBy filter: SeasonFilter) -> SeasonList {
        return seasons.filter(filter)
    }
}
