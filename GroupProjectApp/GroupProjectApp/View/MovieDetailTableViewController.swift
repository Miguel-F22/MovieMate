//
//  MovieDetailTableViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/23/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let movieInfoNetworkController: MovieInfoNetworkController = MovieInfoNetworkController()
    
//    MARK: Outlets and dependencies
    var movieID: Int?
    var collection: Collection?
    var releaseDate: String?
    var overview: String?
    
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var summary: UITextView!
    
    var relatedCharacters: [Character]?
    var relatedObjects: [Object]?
    var relatedEvents: [Event] = [
        Event(name: "Death of a patriot", notes: "It was an epic plot twist"),
        Event(name: "Something big", notes: "Cray cray"),
        Event(name: "Hand Chopped off", notes: "clean cut", relatedEvents: [Event(name: "Death of a patriot", notes: "It was an epic plot twist")])
    ]
    
    func updateView() {
        releaseDateLabel.text = releaseDate
        summary.text = overview
        
    }
    
    

    override func viewDidLoad() {
        updateView()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//   MARK: Collection stuff
    
    let reuseIdentifier = "eventCell"

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.relatedEvents.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

           // get a reference to our storyboard cell
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! EventsCollectionViewCell

           // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.nameLabel.text = self.relatedEvents[indexPath.item].name
           cell.backgroundColor = UIColor.cyan // make cell more visible in our example project

           return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // handle tap events
           print("You selected cell #\(indexPath.item)!")
       }
    
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
