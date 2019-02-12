//
//  File.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 06/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import Foundation

final class Repository {
    static let local: LocalFactory = LocalFactory()
}

final class LocalFactory { }
