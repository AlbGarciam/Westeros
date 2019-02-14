//
//  LocalFactory+HouseFactory.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 12/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

typealias HouseFilter = (House) -> Bool
typealias HouseList = [House]

protocol HouseFactory {
    var houses: HouseList { get } // Read-only variable
    func house(named name: String) -> House?
    func house(named name: HouseName) -> House?
    func houses(filteredBy filter: HouseFilter) -> HouseList
}

extension LocalFactory: HouseFactory {
    var houses : HouseList {
        // Houses creation
        let starkSigil = Sigil(image: UIImage(named:"codeIsComing") ?? UIImage(), description: "Lobo huargo")
        let starkHouse = House(name: HouseName.stark.rawValue, sigil: starkSigil, words: "Code is coming", wikiURL: starkURL)
        
        let lannisterSigil = Sigil(image: UIImage(named: "lannister") ?? UIImage(), description: "León rampante")
        let lannisterHouse = House(name: HouseName.lannister.rawValue, sigil: lannisterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall") ?? UIImage(), description: "Dragon tricéfalo")
        let targaryenHouse = House(name: HouseName.targaryen.rawValue, sigil: targaryenSigil, words: "Fuego y sangre", wikiURL: targaryenURL)
        
        let _ = Person(name: "Rob", alias: "Young wolf", house: starkHouse)
        let _ = Person(name: "Arya", house: starkHouse)
        let _ = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let _ = Person(name: "Cersei", house: lannisterHouse)
        let _ = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        let _ = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)
        
//        starkHouse.add(persons: rob, arya)
//        lannisterHouse.add(persons: tyrion, cersei, jaime)
//        targaryenHouse.add(persons: daenerys)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        // return houses.filter{ $0.name.lowercased() == name.lowercased() }.first
        return houses.first{ $0.name.caseInsensitiveCompare(name) == .orderedSame }
    }
    
    func houses(filteredBy filter: HouseFilter) -> HouseList {
        return houses.filter(filter)
    }
    
    func house(named name: HouseName) -> House? {
        return house(named: name.rawValue)
    }
}
