//
//  Movie+CoreDataClass.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 2/19/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject, Codable {
    
    
    enum CodingKeys: String, CodingKey {
            case title = "original_title"
            case movieID = "id"
            case overview
            case posterPath = "poster_path"
            //case collection = "belongs_to_collection"
            case voteAverage = "vote_average"
            case releaseDate = "release_date"
            case language = "original_language"
            case popularity
        
        }
        
//    @NSManaged public var movieID: Int32
//    @NSManaged public var overview: String
//    @NSManaged public var posterPath: String
//    @NSManaged public var releaseDate: String
//    @NSManaged public var title: String
//    @NSManaged public var voteAverage: Double
//    @NSManaged public var language: String
//    //@NSManaged public var collection: String?
//    @NSManaged public var popularity: NSDecimalNumber
//    @NSManaged public var movieRelatedCharacters: NSSet?
//    @NSManaged public var movieRelatedEvents: NSSet?
//    @NSManaged public var movieRelatedObjects: NSSet?
        
        convenience init(from decoder: Decoder, relatedCharacters: [Character]?, relatedObjects: [Object]?, relatedEvents: [MovieEvent]?) throws {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                title = try values.decode(String.self, forKey: CodingKeys.title)
                movieID = try values.decode(Int32.self, forKey: CodingKeys.movieID)
                overview = try values.decode(String.self, forKey: CodingKeys.overview)
                posterPath = try values.decode(String.self, forKey: CodingKeys.posterPath)
                //collection = try? values.decode(String.self, forKey: CodingKeys.collection)
                voteAverage = try values.decode(Double.self, forKey: CodingKeys.voteAverage)
                releaseDate = try values.decode(String.self, forKey: CodingKeys.releaseDate)
                language = try values.decode(String.self, forKey: CodingKeys.language)
                popularity = try (values.decode(Double.self, forKey: CodingKeys.popularity) as? NSDecimalNumber)!
            }
            self.movieRelatedCharacters = NSSet(object: relatedCharacters)
            self.movieRelatedObjects = NSSet(object: relatedObjects)
            self.movieRelatedEvents = NSSet(object: relatedEvents)
    //        addToMovieRelatedCharacters(NSSet(object: relatedCharacters))
    //        addToMovieRelatedEvents(NSSet(object: relatedEvents))
    //        addToMovieRelatedObjects(NSSet(object: relatedObjects))
        }
}
