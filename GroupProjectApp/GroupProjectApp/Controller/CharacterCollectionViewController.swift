//
//  CharacterCollectionViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/29/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "chracterCell"

class CharacterCollectionViewController: UICollectionViewController {
    static var shared = CharacterCollectionViewController()
    static var indexOfChar = -1
    static var collectionCharacters: [Character]?
    

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
            if let characterCount = movies[index2].movieRelatedCharacters?.count {
                let characterArray = Array((movies[index2].movieRelatedCharacters?.allObjects as? [Character])!)
//                var sortedArray = characterArray.sorted(by: {$0.name < $1.name})
                let sortedMovies = characterArray.sorted(by: { $0.name! < $1.name! })
                CharacterCollectionViewController.collectionCharacters = sortedMovies
                return characterCount + 1
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
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CharactersCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        guard let characters = CharacterCollectionViewController.collectionCharacters else {
            print("no related characters")
            return cell
        }
        cell.nameLabel.text = characters[indexPath.item - 1].name
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != 0 else {
//            add button stuff
            
            OCEDetailTableViewController.newCharacter = true
            OCEDetailTableViewController.retCharacter = false

            return
        }
        CharacterCollectionViewController.indexOfChar = indexPath.row
        OCEDetailTableViewController.newCharacter = false
        OCEDetailTableViewController.retCharacter = true
        OCEDetailTableViewController.character = CharacterCollectionViewController.collectionCharacters![indexPath.item - 1]
        CharacterCollectionViewController.indexOfChar = indexPath.row - 1
    }
    
}
