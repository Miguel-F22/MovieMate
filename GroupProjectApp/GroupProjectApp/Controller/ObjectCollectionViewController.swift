//
//  ObjectCollectionViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/29/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit
import CoreData
private let reuseIdentifier = "objectCell"

class ObjectCollectionViewController: UICollectionViewController {
    static var shared = ObjectCollectionViewController()
    static var indexOfObj = -1
    static var collectionObj: [MoObject]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


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
            if let objectCount = movies[index2].movieRelatedObjects?.count {
                let objectArray = Array((movies[index2].movieRelatedObjects?.allObjects as? [MoObject])!)
                let sortedObjectsArray = objectArray.sorted(by: { $0.name! < $1.name! })
                ObjectCollectionViewController.collectionObj = sortedObjectsArray
                return objectCount + 1
            }
            
        } catch {
            
        }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.item != 0 else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "plusButton", for: indexPath)
            }
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ObjectsCollectionViewCell
                        
            guard let objects = ObjectCollectionViewController.collectionObj else {
                return cell
            }
            cell.nameLabel.text = objects[indexPath.item - 1].name
            cell.backgroundColor = UIColor.blue
            
            return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != 0 else {
            
            OCEDetailTableViewController.newObject = true
            OCEDetailTableViewController.retObject = false
            return
        }
        ObjectCollectionViewController.indexOfObj = indexPath.row
        OCEDetailTableViewController.newObject = false
        OCEDetailTableViewController.retObject = true
        OCEDetailTableViewController.object = ObjectCollectionViewController.collectionObj![indexPath.item - 1]
        ObjectCollectionViewController.indexOfObj = indexPath.row - 1
    }
}
