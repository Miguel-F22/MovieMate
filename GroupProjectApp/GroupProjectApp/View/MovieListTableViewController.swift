//
//  MovieListTableViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/23/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit


var movieInfoItems: [AMovie] = []

class MovieListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    static var shared = MovieListTableViewController()
    var movieID: Int?
    var collection: Collection?
    var lastSearchText: String = ""
//    var path: IndexPath?

    let movieListController: MovieListItemController = MovieListNetworkController()
    var movieListItem: Movies?
    
    let movieListImageController = MovieListImageNetworkController()
    
    let movieInfoController: MovieInfoItemController = MovieInfoNetworkController()
    
    
    
    var searchController: UISearchController?
    
    //        adds searchbar item to Navigation bar
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
            
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    var characterSet = CharacterSet.init(charactersIn: "qwertyiuioplkjhgfdsazxcvbnm1234567890&!@#$%^*()[].,;/:\'\"\\=-+_ ")
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text != lastSearchText else { return }
        lastSearchText = text
        if text.count > 2 {
            
            movieInfoItems = []
            self.tableView.reloadData()
            let movieListGroup = DispatchGroup()
            movieListGroup.enter()
            movieListController.getMovieListItem(name: text.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)) { response in
                switch response {
                case .success(let movieListItem):
                    self.movieListItem = movieListItem
                    
                    for i in movieListItem.results {
                        movieListGroup.enter()
                        self.movieInfoController.getMovieInfoItem(movie_ID: Int(i.id)) { response in
                            switch response {
                            case .success(let movieInfoItem):
                                DispatchQueue.main.async {
                                    let stringSet = CharacterSet.init(charactersIn: movieInfoItem.title.lowercased())
                                    
                                    if movieInfoItem.language == "en" && stringSet.isSubset(of: self.characterSet) {
                                        movieInfoItems.append(movieInfoItem)
                                        self.tableView.insertRows(at: [IndexPath(row: movieInfoItems.count - 1, section: 0)], with: .automatic)
                                    }
                                    
                                }
                            case .failure:
                                print("Could not find movie from movieID of: " + text)
                            }
                            movieListGroup.leave()
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure:
                    print("Could not find movies from: " + text)
                    
                }
                movieListGroup.leave()
            }
            movieListGroup.notify(queue: .main) {
                
            }
        } else {
            movieInfoItems = []
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        self.tableView.dataSource = self
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfoItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieInfoIdentifier", for: indexPath) as? MovieTableViewCell else {
            fatalError("No cell with id: movieInfoIdentifier that is a MovieTableViewCell 🤯")
        }
        cell.movieTitle.text = movieInfoItems[indexPath.row].title
        cell.movieDate.text = movieInfoItems[indexPath.row].releaseDate
        cell.movieRating.text = String(movieInfoItems[indexPath.row].voteAverage)
        movieListImageController.fetchImage(path: movieInfoItems[indexPath.row].posterPath) { image in
            DispatchQueue.main.async {
                cell.movieImage.image = image
                
            }
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        path = indexPath
        
        performSegue(withIdentifier: "toMovieDetail", sender: nil)
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedRow = tableView.indexPathForSelectedRow?.row, let destination = segue.destination as? MovieDetailTableViewController {
            let id = movieInfoItems[selectedRow].movieID
            let movieTitle = movieInfoItems[selectedRow].title
            let releaseDate = movieInfoItems[selectedRow].releaseDate
            let collectionName = movieInfoItems[selectedRow].collection
            let overview = movieInfoItems[selectedRow].overview
            let imagePath = movieInfoItems[selectedRow].posterPath
            let rating = movieInfoItems[selectedRow].voteAverage
            destination.movieID = id
            destination.collection = collectionName
            destination.title = movieTitle
            destination.releaseDate = releaseDate
            destination.overview = overview
            destination.imagePath = imagePath
            destination.rating = rating
        }
        
    }
    
    
}
