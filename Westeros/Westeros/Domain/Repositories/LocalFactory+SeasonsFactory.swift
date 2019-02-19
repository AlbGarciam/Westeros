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
        guard let path = Bundle.main.path(forResource: "seasons", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
              let seasonList = try? JSONDecoder().decode(SeasonList.self, from: data) else {
            return seasons
        }
        seasons.append(contentsOf: seasonList)
        return seasons.sorted()
    }
    
    func seasons(filteredBy filter: SeasonFilter) -> SeasonList {
        return seasons.filter(filter)
    }
}
