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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }

    func testLocalRepositoryHousesExistence() {
        let houses = Repository.local.houses
        XCTAssertNotNil(houses)
    }
    
    func testLocalRepositoryHouseCount() {
        
        
        
        let houses = Repository.local.houses
        XCTAssertEqual(houses.count, 2)
    }
}
