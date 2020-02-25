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
    //        var movie: Movie = Movie()
            self.init(context: context)
            
            self.movieID = Int32(amovie.movieID)
            self.title = amovie.title
            self.overview = amovie.overview
            self.posterPath = amovie.posterPath
            self.voteAverage = amovie.voteAverage
            self.releaseDate = amovie.releaseDate
            //        self.language = amovie.language
            //        self.popularity = amovie.popularity
            self.movieRelatedCharacters = NSSet(array: amovie.relatedCharacters?.map { Character(movieCharacter: $0, context: context) } ?? [] )
        print("hi")
    //        self.movieRelatedEvents = NSSet(array: amovie.relatedEvents?.map { Event(movieEvent: $0, context: context) } ?? [] )
    //        self.movieRelatedObjects = NSSet(array: amovie.relatedObjects?.map { Object(movieObject: $0, context: context) } ?? [] )
            
        }
}
