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
    
    fileprivate let cellIdLoggedUser = "LoggedUserCell"
    fileprivate let cellIdContact = "ContactCell"
    
    
    fileprivate var contacts = [User]()
    fileprivate var groupedContacts = [String: [User]]()
    fileprivate var sectionTitles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Contacts"
        configureTableView()
        setAddContactButton()
        configureSearchController()
        
        //tirar
        loggedUser = User(name: "Denis Fortuna", phoneNumber: "9999-1234",
                          photoURL: "www.denisfortuna.com", comments: "battery about to dye!")
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
        tableView.register(LoggedUserTableViewCell.self, forCellReuseIdentifier: cellIdLoggedUser)
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: cellIdContact)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    fileprivate func setAddContactButton() {        
        let addContactButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(presentAddContactViewController))
        self.navigationItem.rightBarButtonItem = addContactButton
    }
    
    @objc fileprivate func presentAddContactViewController() {
        
    }
    
    fileprivate func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    fileprivate func fetchData() {
        contacts = FakeUsers.getUsers()
        sortFormatResults()
        tableView.reloadData()
    }
    
    fileprivate func sortFormatResults() {
        groupedContacts = Dictionary(grouping: contacts, by: {String($0.name.prefix(1))})
        guard let user = loggedUser else { return }
        groupedContacts[""] = [user]
        sectionTitles  = groupedContacts.map{ $0.key}.sorted(by: {$0 < $1 })

        
    }

}

extension ContactsListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ContactsListTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sectionTitles[section]
        guard let sectionUsers = groupedContacts[sectionTitle] else { return 0 }
        return sectionUsers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdLoggedUser) as? LoggedUserTableViewCell else { return UITableViewCell() }
            guard let lUser = loggedUser else { return UITableViewCell() }
            cell.formatUI(forUser: lUser)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdContact) as? ContactTableViewCell else { return UITableViewCell() }
            let section = sectionTitles[indexPath.section]
            guard let user = groupedContacts[section]?[indexPath.row] else { return UITableViewCell() }
            cell.formatUI(forContact: user)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    }
}

extension ContactsListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
