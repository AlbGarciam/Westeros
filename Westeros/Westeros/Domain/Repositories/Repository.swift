//
//  File.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 06/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

protocol HouseFactory {
    var houses: [House] { get } // Read-only variable
}


final class Repository {
    static let local: LocalFactory = LocalFactory()
}


final class LocalFactory: HouseFactory {
    var houses : [House] {
        // Houses creation
        let starkSigil = Sigil(image: UIImage(named:"codeIsComing") ?? UIImage(), description: "Lobo huargo")
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Code is coming")
        
        let lannisterSigil = Sigil(image: UIImage(named: "lannister") ?? UIImage(), description: "León rampante")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        let rob = Person(name: "Rob", alias: "Young wolf", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        
        starkHouse.add(person: rob)
        starkHouse.add(person: arya)
        lannisterHouse.add(person: tyrion)
        
        
        return [starkHouse, lannisterHouse]
    }
}
