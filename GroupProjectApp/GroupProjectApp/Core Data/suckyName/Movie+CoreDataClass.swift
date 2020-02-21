//
//  Movie+CoreDataClass.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 2/21/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
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
}
