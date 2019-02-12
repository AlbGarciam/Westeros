//
//  HouseDetailsViewController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 04/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

class HouseDetailsViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var firstLabel: UILabel! {
        didSet {
            firstLabel.font = .boldSystemFont(ofSize: 17)
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
    
    //MARK: Properties
    private(set) var house: House
    
    init(model: House) {
        self.house = model
        // Nil nibname -> tries to load a .xib with the same name than class
        // Nil bundle -> Uses the same as target
        //                          It will be accessible from all bundles
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = house.name
    }
    
    // Apple workaround
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        setUpUI()
    }
    
    //MARK: Sync
    
    func syncModelWithView() {
        firstLabel.text = "House \(house.name)"
        secondLabel.text = house.words
        imageView.image = house.sigil.image
    }
    
    //MARK: UI
    
    func setUpUI() {
        // Add button to navigate to members list
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        // Add button to navigate to wiki
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(wikiButtonAction))
        navigationItem.rightBarButtonItems = [membersButton, wikiButton]
    }
    
    @objc func wikiButtonAction() {
        navigationController?.pushViewController(ChildBrowser(house: house), animated: true)
    }
    
    @objc func displayMembers() {
        navigationController?.pushViewController(MemberListViewController(model: house.sortedMembers), animated: true)
    }
}

extension HouseDetailsViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didRequestedToPresent house: House) {
        self.house = house
        syncModelWithView()
    }
}
