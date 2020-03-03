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
    static var collectionObj: [Object]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
                let objectArray = Array((movies[index2].movieRelatedObjects?.allObjects as? [Object])!)
                //                var sortedArray = characterArray.sorted(by: {$0.name < $1.name})
                let sortedMovies = objectArray.sorted(by: { $0.name! < $1.name! })
                ObjectCollectionViewController.collectionObj = sortedMovies
                return objectCount + 1
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
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ObjectsCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            
            guard let objects = ObjectCollectionViewController.collectionObj else {
                print("no related Objects")
                return cell
            }
            cell.nameLabel.text = objects[indexPath.item - 1].name
            cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
            
            return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != 0 else {
            //            add button stuff
            
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

        
        
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
