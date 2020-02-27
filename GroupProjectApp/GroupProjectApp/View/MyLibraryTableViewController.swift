//
//  MyLibraryTableViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 2/27/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit

class MyLibraryTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    var CoreData: [Movie] = []
    
    
//    MARK: SEARCH BAR STUFF
    
    var searchController: UISearchController?
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
     func setupNavBar() {
                
            searchController = UISearchController(searchResultsController: nil)
            searchController?.searchResultsUpdater = self
            searchController?.obscuresBackgroundDuringPresentation = false
    //        navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        
        navTitle.title = "My Library"
        }

//    MARK: VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CoreData.count
    }
    
//    MARK: NAVIGATION



}
