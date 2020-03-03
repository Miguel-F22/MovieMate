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
            if let characterCount = movies[index2].movieRelatedCharacters?.count {
                let characterArray = Array((movies[index2].movieRelatedCharacters?.allObjects as? [Character])!)
                let sortedCharacterArray = characterArray.sorted(by: { $0.name! < $1.name! })
                CharacterCollectionViewController.collectionCharacters = sortedCharacterArray
                return characterCount + 1
            }
            
        } catch {
            
        }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.item != 0 else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "plusButton", for: indexPath)
        }
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CharactersCollectionViewCell
                
        guard let characters = CharacterCollectionViewController.collectionCharacters else {
            return cell
        }
        cell.nameLabel.text = characters[indexPath.item - 1].name
        cell.backgroundColor = UIColor.orange
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.item != 0 else {
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
