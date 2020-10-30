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
    
    fileprivate var tableView = UITableView()
    fileprivate let backgroundView = UIView()
    
    fileprivate let cellIdLoggedUser = "LoggedUserCell"
    fileprivate let cellIdContact = "ContactCell"
    
    fileprivate var contacts = [User]()
    fileprivate var groupedContacts = [String: [User]]()
    fileprivate var sectionTitles = [String]()
    fileprivate var filteredContacts = [User]()
    
    fileprivate var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Contacts"
        configureTableView()
        setAddContactButton()
        configureSearchController()
        
        //tirar
        loggedUser = User(name: "Denis Fortuna",
                          phoneNumber: "9999-1234",
                          photoURL: "www.denisfortuna.com",
                          comments: "battery about to dye!",
                          email: "denis.fortuna@gmail.com")
    }

    override func viewWillAppear(_ animated: Bool) {
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
        let newContactVC = EditContactViewController()
        newContactVC.formatUI(forUser: nil)
        
        let newContactNavigationController = UINavigationController()
        newContactNavigationController.viewControllers = [newContactVC]
        self.present(newContactNavigationController, animated: true, completion: nil)
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
        formatResultData()
    }
    
    fileprivate func formatResultData() {
        //check if there is no contacts to show either if the user is searching for a contact or
        // if there is no contact to show at all
        if (isSearching && filteredContacts.isEmpty) || (!isSearching && groupedContacts.count == 1) {
            formatMessageNoContacts()
        } else {
            backgroundView.removeFromSuperview()
            tableView.reloadData()
        }
    }
    
    fileprivate func sortFormatResults() {
        //Grouping contacts by their name's Initial letter
        groupedContacts = Dictionary(grouping: contacts, by: {String($0.name.prefix(1))})
        
        // Adding logged user cell as first cell with no header
        guard let user = loggedUser else { return }
        groupedContacts[""] = [user]
        
        //Sorting headers
        sectionTitles  = groupedContacts.map{ $0.key}.sorted(by: {$0 < $1 })
        
        //Sorting names by header
        var sortedContactGroup = [String: [User]]()
        groupedContacts.forEach{
            sortedContactGroup[$0.key] = $0.value.sorted(by: { $0.name < $1.name })
        }
        groupedContacts = sortedContactGroup
    }
    
    fileprivate func formatMessageNoContacts() {
        view.addSubview(backgroundView)
        backgroundView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        backgroundView.anchorEdges(top: tableView.topAnchor,
                                   left: view.leftAnchor,
                                   right: view.rightAnchor,
                                   bottom: view.bottomAnchor,
                                   padding: .zero)
        
        let messageLabel = UILabel()
        backgroundView.addSubview(messageLabel)
        messageLabel.anchorCenters(centerX: backgroundView.centerXAnchor,
                                     centerY: backgroundView.centerYAnchor)
        messageLabel.text = "No Contacts to show"
        
    }
}

extension ContactsListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedUser: User!
        if isSearching {
            selectedUser = filteredContacts[indexPath.row]

        } else {

            //remove logged user from groupedContacts
            groupedContacts[""] = nil
            //look for section
            let section = sectionTitles[indexPath.section]
            //look for user in section
            guard let user = groupedContacts[section]?[indexPath.row] else { return }
            selectedUser = user
        }
        let detailVC = ContactDetailViewController()
        detailVC.formatUI(forUser: selectedUser)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ContactsListTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return 1
        } else {
            return sectionTitles.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredContacts.count
        } else {
            let sectionTitle = sectionTitles[section]
            guard let sectionUsers = groupedContacts[sectionTitle] else { return 0 }
            return sectionUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return ""
        } else {
            return sectionTitles[section]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearching {
            let user = filteredContacts[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdContact) as? ContactTableViewCell else { return UITableViewCell() }
            cell.formatUI(forContact: user)
            return cell
        } else {
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
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    }
}

extension ContactsListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        let searchingText = searchController.searchBar.text!
        if searchingText.isEmpty {
            //when started typing or deleted everything or cancelled search
            isSearching = false
        } else {
            //when typing..either with or without results to show
            filteredContacts = contacts.filter{ $0.name.prefix(searchingText.count) == searchingText}
                .sorted(by: { $0.name < $1.name })
            isSearching = true
        }
        formatResultData()
    }
}
