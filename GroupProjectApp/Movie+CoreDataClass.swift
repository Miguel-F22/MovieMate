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
    
   
    public required convenience init(from decoder: Decoder) throws {
        self.init(context: PersistenceService.context)
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
            popularity = NSDecimalNumber(value: try (values.decode(Double.self, forKey: CodingKeys.popularity)))
        }

    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}



