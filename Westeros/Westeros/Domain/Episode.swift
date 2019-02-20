//
//  Episode.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 11/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import Foundation

final class Episode : Decodable{
    let title: String
    let releaseDate: Date
    
    /// Season of the episode, when it is added on a new season, it will automatically add
    /// itself to the season episode and remove from the other season
    weak var season: Season? {
        didSet {
            oldValue?.remove(episode: self)
            season?.add(episode: self)
        }
    }
    
    fileprivate enum CodingKeys: String, CodingKey {
        case name = "name"
        case releaseDate = "releaseDate"
    }
    
    /// Initializer (Just for testing purposes)
    ///
    /// - Parameters:
    ///   - title: Title of the episode
    ///   - releaseDate: Release date of the episode
    ///   - season: Season of the episode
    init(title: String, releaseDate: Date, season: Season? = nil) {
        self.title = title
        self.releaseDate = releaseDate
        defer {
            self.season = season
        }
    }
    
    /// Decodable initializer
    ///
    /// - Parameter decoder: decoder
    /// - Throws: Can throw an error when parse cannot be performed
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Episode.CodingKeys.self) // defining our (keyed) container
        let title: String = try! container.decode(String.self, forKey: .name)
        let releaseDate: String = try container.decode(String.self, forKey: .releaseDate)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-MM"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        
        let formatDate = formatter.date(from: releaseDate)!
        
        self.init(title: title, releaseDate: formatDate)
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
