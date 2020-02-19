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
        let context = PersistenceService.context

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
    
    
    convenience init(amovie: AMovie, context: NSManagedObjectContext = PersistenceService.context) {
        var movie: Movie = Movie()
        self.init(context: context)
        
        self.movieID = Int32(amovie.movieID)
        self.title = amovie.title
        self.overview = amovie.overview
        self.posterPath = amovie.posterPath
//        self.collection = amovie.collection
        self.voteAverage = amovie.voteAverage
        self.releaseDate = amovie.releaseDate
//        self.language = amovie.language
//        self.popularity = amovie.popularity
        self.movieRelatedCharacters = NSSet(array: amovie.relatedCharacters ?? [] )
        self.movieRelatedEvents = NSSet(array: amovie.relatedEvents ?? [] )
        self.movieRelatedObjects = NSSet(array: amovie.relatedObjects ?? [] )
        
        
    }
    
    static func createMovieRelations(movieToCreate: AMovie, notes: String, with context: NSManagedObjectContext) -> Movie? {
            let context = PersistenceService.context
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
