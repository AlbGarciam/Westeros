//
//  House.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 31/01/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>

final class House {
    //MARK: Properties
    let name: String
    let sigil: Sigil
    let words: Words
    private var _members: Members = Members()
    
    //MARK: Init
    init(name: String, sigil: Sigil, words: Words) {
        self.name = name
        self.sigil = sigil
        self.words = words
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
