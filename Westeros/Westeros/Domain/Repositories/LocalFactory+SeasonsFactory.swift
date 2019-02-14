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
    func seasons(filteredBy filter: SeasonFilter) -> SeasonList
}

extension LocalFactory: SeasonFactory {
    var seasons: SeasonList {
        var seasons = SeasonList()
        EpisodesBySeason.enumerated().forEach { (seasonNumber, episodes) in
            let season = Season(title: "Season \(seasonNumber+1)", releaseDate: Date()+TimeInterval(seasonNumber*300))
            episodes.enumerated().forEach({ (episodeNumber, name) in
                let episode = Episode(title: "\(name) - S\(seasonNumber+1)E\(episodeNumber)",
                    releaseDate: season.releaseDate+TimeInterval((episodeNumber-1)*10),
                    season: season)
                season.add(episode: episode)
            })
            seasons.append(season)
        }
        return seasons.sorted()
    }
    
    func seasons(filteredBy filter: SeasonFilter) -> SeasonList {
        return seasons.filter(filter)
    }
}


var EpisodesBySeason = [
    ["Winter Is Coming", "The Kingsroad", "Lord Snow", "Cripples, Bastards, and Broken Things"],
    ["The North Remembers", "The Night Lands", "What Is Dead May Never Die"],
    ["Valar Dohaeris", "Dark Wings, Dark Words", "Walk of Punishment", "And Now His Watch Is Ended"],
    ["Two Swords", "The Lion and the Rose", "Breaker of Chains"],
    ["The Wars to Come", "The House of Black and White", "High Sparrow"],
    ["The Red Woman", "Home", "Oathbreaker", "Book of the Stranger", "The Door"],
    ["Dragonstone", "Stormborn", "The Queen's Justice"]
]
