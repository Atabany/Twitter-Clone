//
//  ExploreViewController.swift
//  twitterClone
//
//  Created by mohamed elatabany on 4/4/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit


private let reuseIdentifer = "UserCell"

class ExploreController: UITableViewController {
    
    

    
    // -------------------------------------------------
    // MARK: - Properties
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var filteredUsers = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    private var inSearchMode: Bool {
        return searchController.isActive && !(searchController.searchBar.text!.isEmpty)
    }
    

    
    
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    // -------------------------------------------------
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearcController()
        fetchUsers()
    }

    
    private func configureTableView() {
        
        let footerView = UIView()
        self.tableView.tableFooterView = footerView
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifer)
        
        
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
    }
    
    
    // -------------------------------------------------
    // MARK: - Helpers
    private func configureUI() {
        navigationItem.title = "Explore"
        
        configureTableView()
    }
    
    
    func configureSearcController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searchController
        definesPresentationContext = false
        searchController.searchResultsUpdater = self
    }
    
    // -------------------------------------------------
    // MARK: - API
    
    func fetchUsers() {
        UserService.shared.fetchUsers {  users in
            users.forEach { (user) in
                self.users = users
            }
        }
    }
    
    
    
    
    
    
    
    

}


extension ExploreController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  inSearchMode ?  filteredUsers.count :  users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        
        
        let user =  inSearchMode ?  self.filteredUsers[indexPath.row] :   self.users[indexPath.row]
        cell.user = user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user =  inSearchMode ?  self.filteredUsers[indexPath.row] :   self.users[indexPath.row]
        let controller = ProfileController(user: user)
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
}
extension ExploreController:UISearchResultsUpdating  {

    func updateSearchResults(for searchController: UISearchController) {

        guard let  searchText = searchController.searchBar.text?.lowercased() else {
            return
        }

        print("Debug: Search Text is \(searchText)")

        self.filteredUsers = users.filter {
            return $0.fullname.lowercased().contains(searchText) || $0.username.lowercased().contains(searchText)
        }
        
        
        self.tableView.reloadData()

    }
    
    
    
}



