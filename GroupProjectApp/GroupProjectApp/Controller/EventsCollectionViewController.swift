//
//  EventsCollectionViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/29/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit
import CoreData



class EventsCollectionViewController: UICollectionViewController {
    static var indexOfEvent = -1
    static var collectionEvents: [Event]?
    static var shared = EventsCollectionViewController()
    let reuseIdentifier = "eventCell"


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? OCEDetailTableViewController
//        let id: Int? = movieDetailTableController.movieID
//        let collectionName = movieDetailTableController.collection
//        destination?.movieID = id
//        destination?.collection = collectionName
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
     
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard MovieDetailTableViewController.hideOCEviews == false else { return 1 }
                let context = PersistenceService.context
                do {
                    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
                    
                    let movies = try context.fetch(fetchRequest)
                    let index = movies.firstIndex(where: { (item) -> Bool in
                        item.movieID == MyLibraryTableViewController.coreDataGlobalReference?[MyLibraryTableViewController.indexPathOfMovie!].movieID
                    })
                    guard let index2 = index else { return 1 }
                    if let eventCount = movies[index2].movieRelatedEvents?.count {
                        let eventArray = Array((movies[index2].movieRelatedEvents?.allObjects as? [Event])!)
        //                var sortedArray = characterArray.sorted(by: {$0.name < $1.name})
                        let sortedMovies = eventArray.sorted(by: { $0.name! < $1.name! })
                        EventsCollectionViewController.collectionEvents = sortedMovies
                        return eventCount + 1
                    }

                    
                } catch {
                     print("")
                }
                return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.item != 0 else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "plusButton", for: indexPath)
        }
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! EventsCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        guard let events = EventsCollectionViewController.collectionEvents else {
            print("no related events")
            return cell
        }
        cell.nameLabel.text = events[indexPath.item - 1].name
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != 0 else {
            //            add button stuff
            
            OCEDetailTableViewController.newEvent = true
            OCEDetailTableViewController.retEvent = false
            
            return
        }
        CharacterCollectionViewController.indexOfChar = indexPath.row
        OCEDetailTableViewController.newEvent = false
        OCEDetailTableViewController.retEvent = true
        OCEDetailTableViewController.event = EventsCollectionViewController.collectionEvents![indexPath.item - 1]
        CharacterCollectionViewController.indexOfChar = indexPath.row - 1
    }
    
}
