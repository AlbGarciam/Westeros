//
//  House.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 31/01/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!

import Foundation

typealias Words = String
typealias Members = Set<Person>

enum HouseName: String {
    case stark = "Stark"
    case lannister = "Lannister"
    case targaryen = "Targaryen"
}

final class House {
    //MARK: Properties
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members = Members()
    
    //MARK: Init
    init(name: String, sigil: Sigil, words: Words, wikiURL: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = wikiURL
    }
}

extension House {
    var proxyEquality : String { return "\(name) \(words) \(sigil.description)" }
    var proxyComparison : String { return name }
}

extension House {
    var count : Int {
        return _members.count
    }
    
    func add(person: Person) {
        guard person.house == self else { return }
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        persons.forEach{ add(person: $0) }
    }
    
    func remove(person: Person) {
        _members.remove(person)
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    var members: [Person] {
        return Array(_members)
    }
}

extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyEquality == rhs.proxyEquality
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyEquality.hashValue
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        return lhs.proxyComparison < rhs.proxyComparison
    }
}
