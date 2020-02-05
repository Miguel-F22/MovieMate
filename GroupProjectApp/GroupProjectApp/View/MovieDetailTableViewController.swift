//
//  MovieDetailTableViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/23/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    
    let movieInfoNetworkController: MovieInfoNetworkController = MovieInfoNetworkController()
    let eventController: EventsCollectionViewController = EventsCollectionViewController()
    
    
//    MARK: Outlets and dependencies
    var movieID: Int?
    var collection: Collection?
    var releaseDate: String?
    var overview: String?
    
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    static var relatedCharacters: [Character]?
    static var relatedObjects: [Object]?
    static var relatedEvents: [Event] = [
        Event(name: "Death of a patriot", notes: "It was an epic plot twist"),
        Event(name: "Something big", notes: "Cray cray"),
        Event(name: "Hand Chopped off", notes: "clean cut", relatedEvents: [Event(name: "Death of a patriot", notes: "It was an epic plot twist")]),
        Event(name: "Something big", notes: "Cray cray")
    ]
    
    func updateView() {
        releaseDateLabel.text = releaseDate
        summary.text = overview
        
    }
    
    

    override func viewDidLoad() {
        updateView()
        super.viewDidLoad()
        eventCollectionView.dataSource = eventController

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//   MARK: Collection stuff
    
 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? OCEDetailTableViewController
        let id: Int? = movieID
        let collectionName = collection
        destination?.movieID = id
        destination?.collection = collectionName
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
