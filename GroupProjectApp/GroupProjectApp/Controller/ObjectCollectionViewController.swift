//
//  ObjectCollectionViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/29/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "objectCell"

class ObjectCollectionViewController: UICollectionViewController {
    static var shared = ObjectCollectionViewController()

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
        guard let objects = MovieDetailTableViewController.relatedObjects else {
            print("no related objects")
            return 1
        }
        return objects.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.item != 0 else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "plusButton", for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ObjectsCollectionViewCell
    
        // Configure the cell
        
        guard let objects = MovieDetailTableViewController.relatedObjects else {
            print("no related Objects")
            return cell
        }
        
        cell.nameLabel.text = objects[indexPath.item - 1 ].name
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         guard indexPath.item != 0 else {
        //            add button stuff
                    OCEDetailTableViewController.newObject = true
                    return
                }
                OCEDetailTableViewController.newObject = false
//                OCEDetailTableViewController.object = MovieDetailTableViewController.relatedObjects![indexPath.item - 1]
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
