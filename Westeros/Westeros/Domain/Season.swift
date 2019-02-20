//
//  Season.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 11/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season : Decodable {
    let title: String
    
    /// Release date of the season, in case that season doesn't have any episode,
    /// it will use the maximun available date, because it means that season is not ready to be published
    var releaseDate: Date {
        return sortedEpisodes.first?.releaseDate ?? NSDate.distantFuture
    }
    private var _episodes = Episodes()
    
    fileprivate enum CodingKeys: String, CodingKey {
        case title = "title"
        case episodes = "episodes"
    }
    
    /// Initializer (Just for testing purposes)
    ///
    /// - Parameter title: Title of the season
    init(title: String) {
        self.title = title
    }
    
    
    /// Decodable initializer
    ///
    /// - Parameter decoder: decoder
    /// - Throws: Can throw an error when parse cannot be performed
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Season.CodingKeys.self) // defining our (keyed) container
        let title = try container.decode(String.self, forKey: .title)
        let episodes: [Episode] = try container.decode([Episode].self, forKey: .episodes)
        self.init(title: title)
        episodes.forEach { [weak self] episode in
            episode.season = self
        }
    }
    
}
//MARK: Extension of functionality
extension Season {
    //MARK: - Computed Variables
    var numberOfEpisodes: Int {
        return _episodes.count
    }
    
    var episodes: [Episode] {
        return Array(_episodes)
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    //MARK: - Methods
    func add(episode: Episode) {
        guard episode.season == self else { return }
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach{[weak self] in self?.add(episode: $0)}
    }
    
    func add(episodes: [Episode]) {
        episodes.forEach{[weak self] in self?.add(episode: $0)}
    }
    
    func remove(episode: Episode) {
        _episodes.remove(episode)
    }
}


//MARK: Extensions to conform swift extensions
extension Season {
    var proxyForEquatable: String {
        return self.description
    }
    
    var proxyForComparable: Date {
        return self.releaseDate
    }
}

extension Season: CustomStringConvertible {
    var description: String {
        return "\(title) - (\(releaseDate))"
    }
}

extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquatable == rhs.proxyForEquatable
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return description.hashValue
    }
}

extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparable < rhs.proxyForComparable
    }
}
