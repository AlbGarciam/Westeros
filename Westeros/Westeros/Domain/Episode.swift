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
    
    init(title: String, releaseDate: Date, season: Season? = nil) {
        self.title = title
        self.releaseDate = releaseDate
        defer {
            self.season = season
        }
    }
    
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
