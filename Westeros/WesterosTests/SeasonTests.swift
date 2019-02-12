//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Alberto García-Muñoz on 11/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    var season: Season!
    var releaseDate: Date!
    
    var s1e01 : Episode!
    var s1e02 : Episode!
    
    override func setUp() {
        releaseDate = Date()
        
        season = Season(title: "Season Test", releaseDate: releaseDate)
        s1e01 = Episode(title: "Episode S1E01", releaseDate: releaseDate, season: season)
        s1e02 = Episode(title: "Episode S1E02", releaseDate: releaseDate+7, season: season)
        
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season.hashValue)
    }
    
    func testSeasonEquatable() {
        // Identity
        XCTAssertEqual(season, season)
        // Equality
        let season2 = Season(title: season.title, releaseDate: season.releaseDate)
        XCTAssertEqual(season, season2)
        // Desigualdad
        let season3 = Season(title: "Season tests2", releaseDate: releaseDate - 30)
        XCTAssertNotEqual(season, season3)
    }
    
    func testSeasonComparable() {
        let date = releaseDate - 1
        XCTAssertGreaterThan(season, Season(title: "Season teaser", releaseDate: date))
    }
    
    func testSeasonAddEpisodes() {
        XCTAssertEqual(season.numberOfEpisodes, 0)
        season.add(episode: s1e01)
        XCTAssertEqual(season.numberOfEpisodes, 1, "Episode was not added")
        season.add(episode: s1e01)
        XCTAssertEqual(season.numberOfEpisodes, 1, "Episode was added but it exists previously")
        season.add(episode: s1e02)
        XCTAssertEqual(season.numberOfEpisodes, 2, "Episode was not added")
    }
    
    func testSeason_AddMultipleEpisodes_ReturnsNumberOfEpisodesWithSameLength() {
        season.add(episodes: s1e01, s1e02)
        XCTAssertEqual(season.numberOfEpisodes, 2)
    }
    
    func testSeason_SortedEpisodes_ReturnsAnArrayOfSortedEpisodes() {
        season.add(episodes: s1e02, s1e01)
        XCTAssertEqual(season.sortedEpisodes, season.episodes.sorted())
    }
}
