//
//  HouseTest.swift
//  WesterosTests
//
//  Created by Alberto García-Muñoz on 31/01/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import XCTest
@testable import Westeros // We can access to private properties

class HouseTest: XCTestCase {

    var starkHouse : House!
    var starkSigil : Sigil!
    
    var lannisterHouse : House!
    var lannisterSigil : Sigil!
    
    var rob: Person!
    var arya: Person!
    var tyrion: Person!
    
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
        lannisterSigil = Sigil(image: UIImage(), description: "León rampante")
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        rob = Person(name: "Rob", alias: "Young wolf", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
    }

    func testHouseExistence() {
        XCTAssertNotNil(starkHouse, "testHouseExistence - Item does not exist")
    }
    
    func testHouseAddPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(person: rob)
        XCTAssertEqual(starkHouse.count, 1, "Rob was not added")
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2, "Arya was not added")
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2, "Arya was added")
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2, "Tyrion was added")
    }
    
    func testHouseHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseEquatable() {
        // Identity
        XCTAssertEqual(starkHouse, starkHouse)
        // Equality
        let starky = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
        XCTAssertEqual(starky, starkHouse)
        // Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHouseComparable() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
}