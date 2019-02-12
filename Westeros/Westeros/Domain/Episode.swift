//
//  Episode.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 11/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import Foundation

final class Episode {
    let title: String
    let releaseDate: Date
    weak var season: Season?
    
    init(title: String, releaseDate: Date, season: Season) {
        self.title = title
        self.releaseDate = releaseDate
        self.season = season
    }
}

extension Episode {
    var proxyForEquatable: String {
        return self.description
    }
    
    var proxyForComparable: Date {
        return self.releaseDate
    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        return "\(title) - (\(releaseDate))"
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquatable == rhs.proxyForEquatable
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return description.hashValue
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparable < rhs.proxyForComparable
    }
}
