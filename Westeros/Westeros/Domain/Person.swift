//
//  Character.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 31/01/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import Foundation

final class Person {
    let name: String
    private let _alias: String?
    let house: House
    
    var alias: String {
        return _alias ?? ""
    }
    
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        self._alias = alias
        self.house = house
    }
}

extension Person {
    var fullname: String {
        return String(format: "%@ %@", name, house.name)
    }
}

extension Person {
    // Delegamos en otro objeto el calcular el hash
    var proxy: String {
        return "\(name) \(alias) \(house.name)"
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return proxy.hashValue
    }
}

