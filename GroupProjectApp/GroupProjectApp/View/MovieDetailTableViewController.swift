//
//  MovieDetailTableViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/23/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit
import CoreData

var globalMovieID: Int?

protocol MovieDetailProtocol {
    func saved()
}

class MovieDetailTableViewController: UITableViewController, MovieDetailProtocol {
    
    func saved() {
        tableView.reloadData()
        characterCollectionView.reloadData()
        eventCollectionView.reloadData()
        objectCollectionView.reloadData()
    }
    
    static var shared = MovieDetailTableViewController()
    
    let movieInfoNetworkController: MovieInfoNetworkController = MovieInfoNetworkController()
    let eventController = EventsCollectionViewController.shared
    let characterController = CharacterCollectionViewController.shared
    let objectController = ObjectCollectionViewController.shared
    
    let movieListImageController: MovieListImageNetworkController = MovieListImageNetworkController()
    let castCharacterNetworkController: CastCharacterNetworkController = CastCharacterNetworkController()
    
    
    //    MARK: Outlets and dependencies
    
    var movieID: Int?
    var collection: Collection?
    var releaseDate: String?
    var overview: String?
    var imagePath: String?
    var rating: Double?
    var existsInCoreData: Bool = false
    var castCharacterList: [MovieCharacter]? = nil
    
    @IBOutlet weak var addToLibraryButton: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var characterCollectionView: UICollectionView!
    @IBOutlet weak var objectCollectionView: UICollectionView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var characterCell: UITableViewCell!
    
    static var hideOCEviews: Bool?
    static var indexPathSelected: Int?
    static var relatedCharacters: [MovieCharacter]?
    static var relatedObjects: [MovieObject]?
    static var relatedEvents: [MovieEvent]?
    
    //    MARK: FUNCTIONS
    
    func hideORshowOCE() {
        guard let hideOCEViews = MovieDetailTableViewController.hideOCEviews else { return }
        if hideOCEViews {
            eventCollectionView.isHidden = true
            characterCollectionView.isHidden = true
            objectCollectionView.isHidden = true
            characterCell.isHidden = true
        } else {
            
        }
    }
    
    func updateView() {
        releaseDateLabel.text = releaseDate
        summary.text = overview
        ratingLabel.text = String(rating!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        globalMovieID = movieID
        tableView.reloadData()
        hideORshowOCE()
        
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
    
    
    //     MARK: VIEW DID LOAD
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        summary.isEditable = false
        OCEDetailTableViewController.delegate = self
        overrideUserInterfaceStyle = .dark
        
        eventCollectionView.dataSource = eventController
        eventCollectionView.delegate = eventController
        characterCollectionView.dataSource = characterController
        characterCollectionView.delegate = characterController
        objectCollectionView.delegate = objectController
        objectCollectionView.dataSource = objectController
        
        guard let imagePath = imagePath else { return }
        movieListImageController.fetchImage(path: imagePath) { image in
            DispatchQueue.main.async {
                self.movieImage.image = image
            }
        }
        updateView()
        updateButton()
    }
    
    
    //   MARK: Collection stuff
    
    func updateButton() {
        guard let cameFromHome = MovieDetailTableViewController.hideOCEviews else { return }
        if let movieID = movieID {
            if checkCoreDataForMovie(movieToCheckForID: movieID) == nil && cameFromHome {
                existsInCoreData = false
                addToLibraryButton.setTitle("Add to My Library", for: .normal)
            } else if cameFromHome {
                existsInCoreData = true
                addToLibraryButton.setTitle("Already in Library", for: .normal)
                addToLibraryButton.isEnabled = false
            } else if !cameFromHome {
                existsInCoreData = true
                addToLibraryButton.setTitle("Delete From Library", for: .normal)
                addToLibraryButton.isEnabled = true
            }
        }
    }
    
    
    @IBAction func addToLibaryAction(_ sender: Any) {
        guard  let cameFromHome = MovieDetailTableViewController.hideOCEviews, let coreData = MyLibraryTableViewController.coreDataGlobalReference else { return }
        if let selectedRow = indexPathForMovie {
            if !cameFromHome {
                deleteCoreData(movieToDelete: coreData[selectedRow])
                existsInCoreData = false
                addToLibraryButton.setTitle("Delete Succesful", for: .normal)
                addToLibraryButton.isEnabled = false
                navigationController?.popViewController(animated: true)
            } else {
                let context = PersistenceService.context
                _ = Movie.createMovieInCoreData(movieToCreate: movieInfoItems[selectedRow], with: context)
                PersistenceService.saveContext()
                existsInCoreData = true
                addToLibraryButton.setTitle("Added to library", for: .normal)
                addToLibraryButton.isEnabled = false
            }
        }
    }
    
    
    //    MARK: DATASOURCE
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let hideOCEViews = MovieDetailTableViewController.hideOCEviews else { return 0 }
        
        if hideOCEViews {
            return 2
        } else {
            return 5
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "addNewOCE" {
            OCEDetailTableViewController.newOCE = true
        } else if segue.identifier == "updateExistingOCE" {
            OCEDetailTableViewController.newOCE = false
        }
        return
    }
}
