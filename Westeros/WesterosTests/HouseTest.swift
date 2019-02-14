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
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", wikiURL: starkURL)
        lannisterSigil = Sigil(image: UIImage(), description: "León rampante")
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        
        rob = Person(name: "Rob", alias: "Young wolf", house: starkHouse, autoAdd: false)
        arya = Person(name: "Arya", house: starkHouse, autoAdd: false)
        tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse, autoAdd: false)
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
    
    func testHouseAutoAddPerson() {
        XCTAssertEqual(starkHouse.count, 0)
        let _ = Person(name: "This will be autoadded", house: starkHouse)
        XCTAssertEqual(starkHouse.count, 1)
    }
    
    func testHouseAddMultiplePersons() {
        starkHouse.add(persons: tyrion, arya, arya, rob)
        XCTAssertEqual(starkHouse.count, 2, "Tyrion was added")
    }
    
    func testHouseHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseEquatable() {
        // Identity
        XCTAssertEqual(starkHouse, starkHouse)
        // Equality
        let starky = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", wikiURL: starkURL)
        XCTAssertEqual(starky, starkHouse)
        // Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHouseComparable() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    func testHouse_SortedMembers_ReturnsAnArrayOfSortedMembers() {
        starkHouse.add(person: rob)
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.sortedMembers, starkHouse.members.sorted())
    }
}
