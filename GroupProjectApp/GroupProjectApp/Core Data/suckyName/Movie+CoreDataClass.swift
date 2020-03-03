//
//  Movie+CoreDataClass.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 2/24/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    convenience init(amovie: AMovie, context: NSManagedObjectContext = PersistenceService.context) {
            self.init(context: context)
            
            self.movieID = Int32(amovie.movieID)
            self.title = amovie.title
            self.overview = amovie.overview
            self.posterPath = amovie.posterPath
            self.voteAverage = amovie.voteAverage
            self.releaseDate = amovie.releaseDate
            self.movieRelatedCharacters = NSSet(array: amovie.relatedCharacters?.map { Character(movieCharacter: $0, context: context) } ?? [] )
            self.movieRelatedEvents = NSSet(array: amovie.relatedEvents?.map { Event(movieEvent: $0, context: context) } ?? [] )
            self.movieRelatedObjects = NSSet(array: amovie.relatedObjects?.map { MoObject(movieObject: $0, context: context) } ?? [] )
            
        }
    
//    for testing
    convenience init(movieID: Int32, title: String, overview: String, posterPath: String, voteAverage: Double, releaseDate: String) {
        self.init()
        self.movieID = movieID
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
    }
}
