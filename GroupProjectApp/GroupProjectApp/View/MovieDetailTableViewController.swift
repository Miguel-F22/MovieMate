//
//  MovieDetailTableViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/23/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit
import CoreData
//var characterList:[MovieCharacter] = []


class MovieDetailTableViewController: UITableViewController {
    
    static var shared = MovieDetailTableViewController()
    let movieInfoNetworkController: MovieInfoNetworkController = MovieInfoNetworkController()
    let eventController = EventsCollectionViewController.shared
    let characterController = CharacterCollectionViewController.shared

    let movieListImageController: MovieListImageNetworkController = MovieListImageNetworkController()
    let castCharacterNetworkController: CastCharacterNetworkController = CastCharacterNetworkController()
    var castCharacterList: [MovieCharacter]? = nil
    
    
//    MARK: Outlets and dependencies
    var movieID: Int?
    var collection: Collection?
    var releaseDate: String?
    var overview: String?
    var imagePath: String?
    var rating: Double?
    var existsInCoreData: Bool = false
    
    
    @IBOutlet weak var addToLibraryButton: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var characterCollectionView: UICollectionView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    static var indexPathSelected: Int?
    static var relatedCharacters: [MovieCharacter]?
    static var relatedObjects: [MovieObject]?
    static var relatedEvents: [MovieEvent]? = [
        MovieEvent(name: "Death of a patriot", notes: "It was an epic plot twist"),
        MovieEvent(name: "Something big", notes: "Cray cray"),
        MovieEvent(name: "Hand Chopped off", notes: "clean cut"),
        MovieEvent(name: "Something big", notes: "Cray cray")
    ]
    
    func updateView() {
        releaseDateLabel.text = releaseDate
        summary.text = overview
        ratingLabel.text = String(rating!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(true)
        
        
        
        
        eventCollectionView.dataSource = eventController
        characterCollectionView.dataSource = characterController
        characterCollectionView.delegate = characterController
        eventCollectionView.delegate = eventController
        
        castCharacterNetworkController.getCastCharacterItem(movieID: movieID!.description) { response in
             switch response {
                 case .success(let castCharacterListItem):
                     self.castCharacterList = castCharacterListItem
                     MovieDetailTableViewController.relatedCharacters = castCharacterListItem
                     DispatchQueue.main.async {
                     self.characterCollectionView.reloadData()
                }
                 case .failure:
                    print("Could not find any information from: " + String(self.movieID!))
             }
             
        }
    }
    

    override func viewDidLoad() {
        guard let imagePath = imagePath else { return }
        movieListImageController.fetchImage(path: imagePath) { image in
            DispatchQueue.main.async {
                self.movieImage.image = image
            }
        }
        updateView()
        if let movieID = movieID {
            if checkCoreDataForMovie(movieToCheckForID: movieID) == nil {
                existsInCoreData = false
                addToLibraryButton.setTitle("Add to My Library", for: .normal)
            } else {
                existsInCoreData = true
                addToLibraryButton.setTitle("Delete From My Library", for: .normal)
            }
        }
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//   MARK: Collection stuff
    
 
    
    @IBAction func addToLibaryAction(_ sender: Any) {
        if let selectedRow = indexPathForMovie {
            if existsInCoreData {
                deleteCoreData(movieToDelete: movieInfoItems[selectedRow])
                existsInCoreData = false
                addToLibraryButton.setTitle("Add to My Library", for: .normal)
                
            } else {
                
                let context = PersistenceService.context
                _ = Movie.createMovieInCoreData(movieToCreate: movieInfoItems[selectedRow], with: context)
                PersistenceService.saveContext()
                existsInCoreData = true
                addToLibraryButton.setTitle("Delete From My Library", for: .normal)
                
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? OCEDetailTableViewController
        let id: Int? = movieID
        let collectionName = collection
        destination?.movieID = id
        destination?.collection = collectionName
        
        if segue.identifier == "addNewOCE" {
            destination?.newOCE = true
        } else if segue.identifier == "updateExistingOCE" {
            destination?.newOCE = false
        }
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
