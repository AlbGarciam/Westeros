//
//  UISplitViewController+masterAndDetailAccess.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 09/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit
extension UISplitViewController {
    var masterViewController: UIViewController? {
        return viewControllers.first
    }
    
    var detailViewController: UIViewController? {
        guard viewControllers.count == 2 else { return nil }
        return viewControllers.last
    }
}
