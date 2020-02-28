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
    
    var movieListImageController: MovieListImageNetworkController = MovieListImageNetworkController()
    @IBOutlet weak var navTitle: UINavigationItem!
    var coreData: [Movie]? = []
    static var coreDataGlobalReference: [Movie]? = []
    
    
    
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
        MyLibraryTableViewController.coreDataGlobalReference = coreData
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.navigationItem.title = "My Library"
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
        movieListImageController.fetchImage(path: coreData[indexPath.row].posterPath!) { image in
            DispatchQueue.main.async {
                cell.movieImage.image = image

            }
        }
        return cell
}
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192.0;//Choose
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        path = indexPath
        
    }
    
//    MARK: NAVIGATION

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    guard let coreData = coreData else { return }
        if let selectedRow = tableView.indexPathForSelectedRow?.row, let destination = segue.destination as? MovieDetailTableViewController {
            indexPathForMovie = selectedRow
            let id = Int(coreData[selectedRow].movieID)
            let movieTitle = coreData[selectedRow].title
            let releaseDate = coreData[selectedRow].releaseDate
            let overview = coreData[selectedRow].overview
            let imagePath = coreData[selectedRow].posterPath
            let rating = coreData[selectedRow].voteAverage
            destination.movieID = id
            destination.title = movieTitle
            destination.releaseDate = releaseDate
            destination.overview = overview
            destination.imagePath = imagePath
            destination.rating = rating
            
            MovieDetailTableViewController.hideOCEviews = false
            
        }
        
    }

    
}
