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
    weak var house: House?
    
    var alias: String {
        return _alias ?? ""
    }
    
    init(name: String, alias: String? = nil, house: House, autoAdd: Bool = true) {
        self.name = name
        self._alias = alias
        self.house = house
        guard autoAdd else { return }
        self.house?.add(person: self)
    }
}

extension Person {
    var fullname: String {
        return String(format: "%@ %@", name, house?.name ?? "")
    }
}

extension Person {
    // Delegamos en otro objeto el calcular el hash
    var proxyForEquality: String {
        return "\(name) \(alias) \(house?.name ?? "")"
    }
    
    var proxyForComparable: String {
        return "\(name)"
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparable < rhs.proxyForComparable
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

