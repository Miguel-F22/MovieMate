//
//  Movie+CoreDataProperties.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 2/24/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var movieID: Int32
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var movieRelatedCharacters: NSSet?
    @NSManaged public var movieRelatedEvents: NSSet?
    @NSManaged public var movieRelatedObjects: NSSet?

}

// MARK: Generated accessors for movieRelatedCharacters
extension Movie {

    @objc(addMovieRelatedCharactersObject:)
    @NSManaged public func addToMovieRelatedCharacters(_ value: Character)

    @objc(removeMovieRelatedCharactersObject:)
    @NSManaged public func removeFromMovieRelatedCharacters(_ value: Character)

    @objc(addMovieRelatedCharacters:)
    @NSManaged public func addToMovieRelatedCharacters(_ values: NSSet)

    @objc(removeMovieRelatedCharacters:)
    @NSManaged public func removeFromMovieRelatedCharacters(_ values: NSSet)

}

// MARK: Generated accessors for movieRelatedEvents
extension Movie {

    @objc(addMovieRelatedEventsObject:)
    @NSManaged public func addToMovieRelatedEvents(_ value: Event)

    @objc(removeMovieRelatedEventsObject:)
    @NSManaged public func removeFromMovieRelatedEvents(_ value: Event)

    @objc(addMovieRelatedEvents:)
    @NSManaged public func addToMovieRelatedEvents(_ values: NSSet)

    @objc(removeMovieRelatedEvents:)
    @NSManaged public func removeFromMovieRelatedEvents(_ values: NSSet)

}

// MARK: Generated accessors for movieRelatedObjects
extension Movie {

    @objc(addMovieRelatedObjectsObject:)
    @NSManaged public func addToMovieRelatedObjects(_ value: Object)

    @objc(removeMovieRelatedObjectsObject:)
    @NSManaged public func removeFromMovieRelatedObjects(_ value: Object)

    @objc(addMovieRelatedObjects:)
    @NSManaged public func addToMovieRelatedObjects(_ values: NSSet)

    @objc(removeMovieRelatedObjects:)
    @NSManaged public func removeFromMovieRelatedObjects(_ values: NSSet)

}
