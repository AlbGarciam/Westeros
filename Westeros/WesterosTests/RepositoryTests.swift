//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Alberto García-Muñoz on 06/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {

    var houses : HouseList!
    var seasons: SeasonList!
    
    override func setUp() {
        houses = Repository.local.houses
        seasons = Repository.local.seasons
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }

    func testLocalRepositoryHousesExistence() {
        XCTAssertNotNil(houses)
    }
    
    func testLocalRepositorySeasonsExistence() {
        XCTAssertNotNil(seasons)
    }
    
    func testLocalRepositoryHouseCount() {
        XCTAssertEqual(houses.count, 3)
    }
    
    func testLocalRepositorySeasonCount() {
        XCTAssertEqual(seasons.count, 7)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnsSortedArrayOfSeasons() {
        XCTAssertEqual(seasons, seasons.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByNameCaseInsensitive() {
        let stark = Repository.local.house(named: "StArk")
        XCTAssertNotNil(stark)
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryFilterHousesByReturnsCorrectValue() {
        let filtered = Repository.local.houses {
            $0.count == 1
        }
        XCTAssertEqual(filtered.count, 1)
    }
    
    func testLocalRepositoryFilterSeasonsByReturnsCorrectValue() {
        let filtered = Repository.local.seasons{
            $0.title == "Season 1"
        }
        XCTAssertEqual(filtered.count, 1)
    }
}
