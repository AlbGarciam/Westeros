//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 13/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    
    @IBOutlet weak var aliasLabel: UILabel!
    
    let person : Person
    init(model: Person) {
        person = model
        // Nil nibname -> tries to load a .xib with the same name than class
        // Nil bundle -> Uses the same as target
        //                          It will be accessible from all bundles
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.fullname
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        aliasLabel.text = person.fullname
    }
    
}
