//
//  OCEDetailTableViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/23/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit

class OCEDetailTableViewController: UITableViewController {
    
//    MARK: Outlets and Dependencies
    static var newCharacter: Bool? = false
    static var newEvent: Bool? = false
    static var newObject: Bool? = false
    var movieID: Int?
    var collection: Collection?
    var newOCE: Bool = true
    @IBOutlet weak var characterNameTextView: UITextView!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var relatedCharacterNotesTextView: UITextView!
    @IBOutlet weak var relatedObjectsNotesTextView: UITextView!
    @IBOutlet weak var relatedEventsNotesTextView: UITextView!
    
    static var character: MovieCharacter?
    static var event: MovieEvent?
    static var object: MovieObject?
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        OCEDetailTableViewController.newCharacter = false
        OCEDetailTableViewController.newEvent = false
        OCEDetailTableViewController.newObject = false
        
    }
    

//    MARK: Save Button
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if newOCE == true {
            print("Adding new")
        } else {
            print("updating")
        }
        dismiss(animated: true, completion: nil)
    }
    
    
//    MARK: VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        OCEDetailTableViewController.newCharacter = false
        OCEDetailTableViewController.newEvent = false
        OCEDetailTableViewController.newObject = false
        OCEDetailTableViewController.character = nil
        OCEDetailTableViewController.event = nil
        OCEDetailTableViewController.object = nil
    }
    
    
//    MARK: UPDATE VIEW
    
    func updateView() {
        
        guard let newCharacter = OCEDetailTableViewController.newCharacter, let newEvent = OCEDetailTableViewController.newEvent, let newObject = OCEDetailTableViewController.newObject else { return }
        
        
        if !newCharacter && !newObject && !newEvent {
            characterNameTextView.text = OCEDetailTableViewController.character?.name ?? OCEDetailTableViewController.event?.name ?? OCEDetailTableViewController.object?.name ?? ""
            navTitle.title = "Edit existing"
        } else if newCharacter {
            navTitle.title = "Add a character"
            characterNameTextView.text = "Add Character's name"
        } else if newEvent {
            navTitle.title = "Add a new Event"
            characterNameTextView.text = "Add a name for the event"
        } else if newObject {
            navTitle.title = "Add a new Object"
            characterNameTextView.text = "Add a name for your object"
        }
        
        
        
    }

}
