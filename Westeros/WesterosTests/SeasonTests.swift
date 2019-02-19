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
        season = Season(title: "Test")
        s1e01 = Episode(title: "Episode S1E01", releaseDate: Date(), season: season)
        s1e02 = Episode(title: "Episode S1E02", releaseDate: Date()+50, season: season)
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
        let season2 = Season(title: season.title)
        let _ = Episode(title: season.title, releaseDate: season.releaseDate, season: season2)
        XCTAssertEqual(season, season2)
        // Desigualdad
        let season3 = Season(title: "Season tests2")
        XCTAssertNotEqual(season, season3)
    }
    
    func testSeasonComparable() {
        let previousSeason = Season(title: "Previous season")
        let _ = Episode(title: "Initial", releaseDate: NSDate.distantPast, season: previousSeason)
        XCTAssertGreaterThan(season, previousSeason)
    }
    
    func testSeasonAddEpisodes() {
        XCTAssertEqual(season.numberOfEpisodes, 2)
        season.add(episode: s1e01)
        XCTAssertEqual(season.numberOfEpisodes, 2, "Episode was added")
        let _ = Episode(title: "New", releaseDate: Date(), season: season)
        XCTAssertEqual(season.numberOfEpisodes, 3, "Episode was added but it exists previously")
    }
    
    func testSeason_AddMultipleEpisodes_ReturnsNumberOfEpisodesWithSameLength() {
        season.add(episodes: s1e01, s1e02)
        XCTAssertEqual(season.numberOfEpisodes, 2)
    }
    
    func testSeason_SortedEpisodes_ReturnsAnArrayOfSortedEpisodes() {
        season.add(episodes: s1e02, s1e01)
        XCTAssertEqual(season.sortedEpisodes, season.episodes.sorted())
    }
    
    func testSeasonDescription() {
        XCTAssertEqual(season.description, "\(season.title) - (\(season.releaseDate))")
    }
}
