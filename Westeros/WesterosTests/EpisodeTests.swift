//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Alberto García-Muñoz on 11/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    var season: Season!
    var episode: Episode!
    
    override func setUp() {
        self.season = Season(title: "Temporada", releaseDate: Date())
        self.episode = Episode(title: "Test", releaseDate: Date(), season: self.season)
    }

    func testEpisodeExistence() {
        XCTAssertNotNil(episode)
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil(episode.hashValue)
    }
    
    func testEpisodeEquatable() {
        // Identity
        XCTAssertEqual(episode, episode)
        // Equality
        let episode2 = Episode(title: episode.title, releaseDate: episode.releaseDate, season: season)
        XCTAssertEqual(episode, episode2)
        // Desigualdad
        let episode3 = Episode(title: "Hello", releaseDate: Date(), season: season)
        XCTAssertNotEqual(episode, episode3)
    }
    
    func testEpisodeComparable() {
        let date = Date() - 1
        XCTAssertGreaterThan(episode, Episode(title: "hello", releaseDate: date, season: season))
    }
    
    func testEpisodeDescription() {
        let date = Date()
        let episode = Episode(title: "Test", releaseDate: date, season: season)
        
        XCTAssertEqual(episode.description, "\(episode.title) - (\(date))")
    }
}
