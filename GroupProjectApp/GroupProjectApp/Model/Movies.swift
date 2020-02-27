//
//  Movies.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/17/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation

struct Movies: Codable {
    let results: [MovieData]
}

struct MovieData: Codable {
    var id: Int
    
}

struct AMovie: Codable, Equatable {
    static func == (lhs: AMovie, rhs: AMovie) -> Bool {
        return lhs.movieID == rhs.movieID
    }

    var title: String
    var movieID: Int
    var overview: String
    var posterPath: String
    var collection: String?
    var voteAverage: Double
    var releaseDate: String
    var language: String
    var popularity: Double

    var relatedCharacters: [MovieCharacter]?
    var relatedObjects: [MovieObject]?
    var relatedEvents: [MovieEvent]?

    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case movieID = "id"
        case overview
        case posterPath = "poster_path"
        case collection = "belongs_to_collection"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case language = "original_language"
        case popularity
    }
    
    init(from decoder: Decoder, relatedCharacters: [MovieCharacter]?, relatedObjects: [MovieObject]?, relatedEvents: [MovieEvent]?) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            title = try values.decode(String.self, forKey: CodingKeys.title)
            movieID = try values.decode(Int.self, forKey: CodingKeys.movieID)
            overview = try values.decode(String.self, forKey: CodingKeys.overview)
            posterPath = try values.decode(String.self, forKey: CodingKeys.posterPath)
            collection = try? values.decode(String.self, forKey: CodingKeys.collection)
            voteAverage = try values.decode(Double.self, forKey: CodingKeys.voteAverage)
            releaseDate = try values.decode(String.self, forKey: CodingKeys.releaseDate)
            language = try values.decode(String.self, forKey: CodingKeys.language)
            popularity = try values.decode(Double.self, forKey: CodingKeys.popularity)
        }
        self.relatedCharacters = relatedCharacters
        self.relatedObjects = relatedObjects
        self.relatedEvents = relatedEvents
    }
    
    
}

struct Collection: Codable {
    var name: String
}
