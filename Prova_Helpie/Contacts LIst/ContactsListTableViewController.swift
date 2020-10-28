//
//  ContactsListViewController.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 27/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import UIKit

class ContactsListTableViewController: UIViewController {
    
    var loggedUser: User?
    
    fileprivate var loggedUserPhoto = UIImageView()
    fileprivate var loggedUserNameLabel = UILabel()
    fileprivate var tableView = UITableView()
    fileprivate var contacts = [User]()
    fileprivate let cellId = "ContactCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Contacts"
        configureTableView()
        setAddContactButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        loggedUserNameLabel.text = "Denis"
        fetchData()
    }
    
    fileprivate func configureTableView() {
        view.addSubview(tableView)
        tableView.anchorEdges(top: self.view.safeAreaLayoutGuide.topAnchor,
                              left: self.view.safeAreaLayoutGuide.leftAnchor,
                              right: self.view.safeAreaLayoutGuide.rightAnchor,
                              bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                              padding: .init(top: 12, left: 0, bottom: -12, right: 0))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LoggedUserTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    fileprivate func setAddContactButton() {        
        let addContactButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(presentAddContactViewController))
        self.navigationItem.rightBarButtonItem = addContactButton
    }
    
    @objc fileprivate func presentAddContactViewController() {
        
    }
    
    fileprivate func fetchData() {
        tableView.reloadData()
    }

}

extension ContactsListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ContactsListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        contacts.count
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? LoggedUserTableViewCell else { return UITableViewCell() }
        cell.formatUI(forContactName: "Denis Fortuna Denis Fortuna", andPhoto: "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    }
}

