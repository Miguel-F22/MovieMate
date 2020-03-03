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

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
                        let sortedEventArray = eventArray.sorted(by: { $0.name! < $1.name! })
                        EventsCollectionViewController.collectionEvents = sortedEventArray
                        return eventCount + 1
                    }
                    
                } catch {
                    
                }
                return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.item != 0 else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "plusButton", for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! EventsCollectionViewCell
        guard let events = EventsCollectionViewController.collectionEvents else {
            return cell
        }
        cell.nameLabel.text = events[indexPath.item - 1].name
        cell.backgroundColor = UIColor(red:0.25, green:0.35, blue:0.25, alpha:1.0)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != 0 else {
            
            OCEDetailTableViewController.newEvent = true
            OCEDetailTableViewController.retEvent = false
            return
        }
        EventsCollectionViewController.indexOfEvent = indexPath.row
        OCEDetailTableViewController.newEvent = false
        OCEDetailTableViewController.retEvent = true
        OCEDetailTableViewController.event = EventsCollectionViewController.collectionEvents![indexPath.item - 1]
        EventsCollectionViewController.indexOfEvent = indexPath.row - 1
    }
}
