//
//  SigilTests.swift
//  WesterosTests
//
//  Created by Alberto García-Muñoz on 31/01/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import XCTest
@testable import Westeros // We can access to private properties

class SigilTests: XCTestCase {

    
    func testSigilExistence() {
        let sigil = Sigil(image: UIImage(), description: "texto")
        XCTAssertNotNil(sigil, "testSigilExistence - Item does not exist")
    }

}
