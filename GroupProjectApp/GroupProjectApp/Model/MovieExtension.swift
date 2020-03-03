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
    
    static func createMovieInCoreData(movieToCreate: AMovie, with context: NSManagedObjectContext) -> Movie? {
        let context = PersistenceService.context

        guard let movie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as? Movie else { fatalError("Movie entity should exist!")}
        movie.movieID = Int32(movieToCreate.movieID)
        movie.overview = movieToCreate.overview
        movie.posterPath = movieToCreate.posterPath
        movie.releaseDate = movieToCreate.releaseDate
        movie.title = movieToCreate.title
        movie.voteAverage = movieToCreate.voteAverage
        movie.movieRelatedCharacters = NSSet(array: MovieDetailTableViewController.relatedCharacters?.map { Character(movieCharacter: $0, context: context) } ?? [] )
        return movie
    }
}
