//
//  CoreDataFunctions.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 2/13/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation
import CoreData
import UIKit


//  MARK: DELETE MOVIE

func deleteCoreData(movieToDelete: Movie) {
    let context = PersistenceService.context
    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
    do {
        let movies = try context.fetch(fetchRequest)
        let index = movies.firstIndex(where: { (item) -> Bool in
            item.movieID == movieToDelete.movieID
        })
        guard let index2 = index else { return }
        context.delete(movies[index2])
        print("Should have deleted from library?")
        PersistenceService.saveContext()
        
    } catch {
        print(error)
    }
}

//  MARK: ADD NEW OCE TO MOVIE

func addNewOCEInMovie(movieIDToAddInto: Int, oceToInsert: Any, oceType: String) {
    let context = PersistenceService.context
    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
    do {
        let movies = try context.fetch(fetchRequest)
        let index = movies.firstIndex(where: { (item) -> Bool in
            item.movieID == movieIDToAddInto
        })
        guard let index2 = index else { return }
        if oceType == "char" {
            if let character = oceToInsert as? MovieCharacter {
                let theChar = Character(movieCharacter: character, context: context)
                theChar.parentMovie = movies[index2]
                movies[index2].movieRelatedCharacters?.adding(theChar)
            }
        } else if oceType == "obj" {
            if let object = oceToInsert as? MovieObject {
                let theObj = MoObject(movieObject: object, context: context)
                theObj.parentMovie = movies[index2]
                movies[index2].movieRelatedObjects?.adding(theObj)
            }
        } else if oceType == "event" {
            if let event = oceToInsert as? MovieEvent {
                let theEvent = Event(movieEvent: event, context: context)
                theEvent.parentMovie = movies[index2]
                movies[index2].movieRelatedEvents?.adding(theEvent)
            }
        }
        PersistenceService.saveContext()
    } catch {
        print(error)
    }
    return
}

//  MARK: UPDATE EXISTING OCE

func updateOCEInMovie(movieIDToAddInto: Int, oceToInsert: Any, oldOCEName: String, oceType: String) {
    let context = PersistenceService.context
    do {
        if oceType == "char" {
            if let character = oceToInsert as? MovieCharacter {
                
                let commitPredicate = NSPredicate(format: "name == %@", oldOCEName)
                let fetchRequest2 = NSFetchRequest<Character>(entityName: "Character")
                fetchRequest2.predicate = commitPredicate
                
                let results = try context.fetch(fetchRequest2)
                if results.count > 0 {
                    results[0].name = character.name
                    results[0].notes = character.notes
                    results[0].characters = character.relatedCharacters
                    results[0].events = character.relateEvents
                    results[0].objects = character.relatedObjects
                }
            }
        } else if oceType == "obj" {
            if let object = oceToInsert as? MovieObject {
                let commitPredicate = NSPredicate(format: "name == %@", oldOCEName)
                let fetchRequest2 = NSFetchRequest<MoObject>(entityName: "MoObject")
                fetchRequest2.predicate = commitPredicate
                
                let results = try context.fetch(fetchRequest2)
                if results.count > 0 {
                    results[0].name = object.name
                    results[0].notes = object.notes
                    results[0].characters = object.relatedCharacters
                    results[0].events = object.relateEvents
                    results[0].objects = object.relatedObjects
                }
            }
        } else if oceType == "event" {
            if let event = oceToInsert as? MovieEvent {
                let commitPredicate = NSPredicate(format: "name == %@", oldOCEName)
                let fetchRequest2 = NSFetchRequest<Event>(entityName: "Event")
                fetchRequest2.predicate = commitPredicate
                
                let results = try context.fetch(fetchRequest2)
                if results.count > 0 {
                    results[0].name = event.name
                    results[0].notes = event.notes
                    results[0].characters = event.relatedCharacters
                    results[0].events = event.relateEvents
                    results[0].objects = event.relatedObjects
                }
            }
        }
        PersistenceService.saveContext()
        
    } catch {
        print(error)
    }
    return
}

//  MARK: DELETE OCE

func deleteOCEFromMovie(movieToDeleteFrom: Int, oceToDelete: Any, oceType: String, oldOCEName: String) {
    let context = PersistenceService.context
    do {
        if oceType == "char" {
            if let character = oceToDelete as? MovieCharacter {
                let commitPreicate = NSPredicate(format: "name == %@", oldOCEName)
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Character")
                fetchRequest.predicate = commitPreicate
                
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    context.delete(results.first!)
                }
            }
        }
        
        if oceType == "obj" {
            if let object = oceToDelete as? MovieObject {
                let commitPreicate = NSPredicate(format: "name == %@", oldOCEName)
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MoObject")
                fetchRequest.predicate = commitPreicate
                
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    context.delete(results.first!)
                }
            }
        }
        
        if oceType == "event" {
            if let object = oceToDelete as? MovieEvent {
                let commitPreicate = NSPredicate(format: "name == %@", oldOCEName)
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Event")
                fetchRequest.predicate = commitPreicate
                
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    context.delete(results.first!)
                }
            }
        }
        
        PersistenceService.saveContext()
    } catch {
        print(error)
    }
}

//  MARK: CHECK CORE DATA FOR MOVIE

// Finds movie by the id in core data. If it does not exist it returns nil. If it does, returns the core data Movie object.

func checkCoreDataForMovie(movieToCheckForID: Int) -> Movie? {
    let context = PersistenceService.context
    
    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
    do {
        let movies = try context.fetch(fetchRequest)
        let index = movies.firstIndex(where: { (item) -> Bool in
            item.movieID == movieToCheckForID
        })
        if let index = index {
            return movies[index]
        }
        
    } catch {
        print(error)
    }
    return nil
    
}


