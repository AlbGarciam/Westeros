//
//  WesterosConstants.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 11/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var houseDidChanged = Notification.Name("houseDidChanged")
}

enum NotificationKeys: String {
    case HouseDidChanged = "HouseDidChanged"
}

enum UserDefaultsKeyNames: String {
    case lastSelectedHouse = "lastSelectedHouse"
}
