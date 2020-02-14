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
    guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }

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
    guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
    do {
        let movies = try context.fetch(fetchRequest)
        for movie in movies {
            context.delete(movies[movies.firstIndex(of: movie)!])
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        
        print(movies.count)
    } catch {
        print(error)
    }
}

func createCoreDataWithoutRelations(movieToCreate: AMovie) {
    guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
    _ = Movie.createMovieWithoutRelations(movieToCreate: movieToCreate, with: context)
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    
}

func createCoreDataWithRelations() {
    
}


// Finds movie by the id in core data. If it does not exist it returns nil. If it does, returns the core data Movie object.
func checkCoreDataForMovie(movieToCheckForID: Int) -> Movie? {
    guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil}

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
