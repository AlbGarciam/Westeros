//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Alberto García-Muñoz on 31/01/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {
    var house: House!
    var sigil: Sigil!
    var ned: Person!
    
    override func setUp() {
        sigil = Sigil(image: UIImage(), description: "Descripcion")
        house = House(name: "name", sigil: sigil, words: "Se acerca el invierno")
        ned = Person(name: "Ned", alias: "Stark", house: house)
    }
    
    func testPersonExistence() {
        let character = Person(name: "Personaje", alias: "Alias", house: house)
        XCTAssertNotNil(character, "testCharactersExistence - Item does not exist")
    }
    
    func testPersonFullname() {
        let character = Person(name: "Personaje", alias: "Alias", house: house)
        let correctName = "Personaje \(house.name)"
        XCTAssertEqual(correctName, character.fullname)
    }
    
    func testPersonHashable() {
        XCTAssertNotNil(ned.hashValue)
    }
    
    func testPersonEquatable() {
        // Identity
        XCTAssertEqual(ned, ned)
        // Equality
        let eddard = Person(name: "Ned", alias: "Stark", house: house)
        XCTAssertEqual(eddard, ned)
        // Desigualdad
        let character2 = Person(name: "Personaje", alias: "Alias", house: house)
        XCTAssertNotEqual(ned, character2)
    }

}

