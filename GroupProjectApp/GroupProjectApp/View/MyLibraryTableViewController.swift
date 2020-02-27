//
//  MyLibraryTableViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 2/27/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit
import CoreData

class MyLibraryTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    var coreData: [Movie]? = []
    
    
    
//    MARK: SEARCH BAR STUFF
    
    var searchController: UISearchController?
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
     func setupNavBar() {
                navigationController?.navigationBar.prefersLargeTitles = true
        
            searchController = UISearchController(searchResultsController: nil)
            searchController?.searchResultsUpdater = self
            searchController?.obscuresBackgroundDuringPresentation = false
    //        navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        
        navTitle.title = "My Library"
        }

//    MARK: VIEW DID LOAD
    
    override func viewWillAppear(_ animated: Bool) {
        coreData = fetchMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fetchMovies() -> [Movie]? {
        let context = PersistenceService.context

        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        do {
            let movies = try context.fetch(fetchRequest)
            var realMovies: [Movie] = []
            for i in movies {
                if i.title != nil {
                    realMovies.append(i)
                }
            }
            return realMovies
           
        } catch {
            print(error)
        }
        return nil
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieInfoIdentifier", for: indexPath) as? MovieTableViewCell else {
            fatalError("No cell with id: movieInfoIdentifier that is a MovieTableViewCell 🤯")
        }
        guard let coreData = coreData else { return cell }

        cell.movieTitle.text = coreData[indexPath.row].title
        cell.movieDate.text = coreData[indexPath.row].releaseDate
        cell.movieRating.text = String(coreData[indexPath.row].voteAverage)
//        movieListImageController.fetchImage(path: CoreData[indexPath.row].posterPath) { image in
//            DispatchQueue.main.async {
//                cell.movieImage.image = image
//
//            }
        
        return cell
}
    
//    MARK: NAVIGATION



}
