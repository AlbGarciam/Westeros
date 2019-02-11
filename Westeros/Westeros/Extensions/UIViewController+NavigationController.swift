//
//  UIViewController+NavigationController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 05/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrapInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

