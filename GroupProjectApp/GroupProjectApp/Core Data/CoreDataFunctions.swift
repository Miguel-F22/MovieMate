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

func fetchCoreData() {
    let context = PersistenceService.context
    
    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
    do {
        let movies = try context.fetch(fetchRequest)
        if movies.count > 0 {
            // Do something with movies
        }
    } catch {
        print(error)
    }
}

func deleteCoreData() {
    let context = PersistenceService.context
    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
    do {
        let movies = try context.fetch(fetchRequest)
        for movie in movies {
            context.delete(movies[movies.firstIndex(of: movie)!])
        }
        PersistenceService.saveContext()
        
        print(movies.count)
    } catch {
        print(error)
    }
}

func createCoreDataWithoutRelations(movieToCreate: Movie) {
    let context = PersistenceService.context
    _ = Movie.createMovieWithoutRelations(movieToCreate: movieToCreate, relatedCharacters: [], with: context)
    PersistenceService.saveContext()
    
}

func createCoreDataWithRelations() {
    
}


// Finds movie by the id in core data. If it does not exist it returns nil. If it does, returns the core data Movie object.
func checkCoreDataForMovie(movieToCheckForID: Int32) -> Movie? {
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
