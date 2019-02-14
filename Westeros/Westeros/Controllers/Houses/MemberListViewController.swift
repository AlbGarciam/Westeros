//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 07/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    //MARK: Properties
    private(set) var model: [Person]
    
    //MARK: Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(houseDidChanged(_:)),
                                               name: NSNotification.Name.houseDidChanged,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func houseDidChanged(_ notification: Notification) {
        let userData = notification.userInfo
        guard let newHouse = userData?[NotificationKeys.HouseDidChanged] as? House else { return }
        self.model = newHouse.members
        tableView.reloadData()
    }
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = model[indexPath.row]
        navigationController?.pushViewController(MemberDetailViewController(model: person), animated: true)
    }
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = model[indexPath.row]
        let cellId = "MemberCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = person.fullname
        cell.detailTextLabel?.text = person.alias
        return cell
    }
}
