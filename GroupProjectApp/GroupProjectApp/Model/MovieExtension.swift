//
//  MovieExtension.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 2/13/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

extension Movie {
    
    static func createMovieWithoutRelations(movieToCreate: AMovie, with context: NSManagedObjectContext) -> Movie? {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil }
        guard let movie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as? Movie else { fatalError("Movie entity should exist!")}
        movie.movieID = Int32(movieToCreate.movieID)
        movie.overview = movieToCreate.overview
        movie.posterPath = movieToCreate.posterPath
        movie.releaseDate = movieToCreate.releaseDate
        movie.title = movieToCreate.title
        movie.voteAverage = movieToCreate.voteAverage
        movie.movieRelatedCharacters = []
//        movie.movieRelatedObjects = []
        movie.movieRelatedEvents = []
        print("🧷")
        return movie
    }
    
    
    
    
    static func createMovieRelations(movieToCreate: AMovie, notes: String, with context: NSManagedObjectContext) -> Movie? {
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil }
            guard let movie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as? Movie else { fatalError("Movie entity should exist!")}
            
            
            
            
            if let movieRelatedChars = movieToCreate.relatedCharacters {
                for i in movieRelatedChars {
                    let character = Character()
                    character.name = i.name
                    movie.addToMovieRelatedCharacters(character)
    
    
    
                }
            }
            return movie
        }
    
}
