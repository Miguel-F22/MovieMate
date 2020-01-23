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

struct Movie: Codable {
    var title: String
    var movieID: Int
    var overview: String
    var posterPath: String
    var collection: Collection
    var voteAverage: Double
    var releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case movieID = "id"
        case overview
        case posterPath = "poster_path"
        case collection = "name"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            title = try values.decode(String.self, forKey: CodingKeys.title)
            movieID = try values.decode(Int.self, forKey: CodingKeys.movieID)
            overview = try values.decode(String.self, forKey: CodingKeys.overview)
            posterPath = try values.decode(String.self, forKey: CodingKeys.posterPath)
            collection = try values.decode(Collection.self, forKey: CodingKeys.collection)
            voteAverage = try values.decode(Double.self, forKey: CodingKeys.voteAverage)
            releaseDate = try values.decode(String.self, forKey: CodingKeys.releaseDate)
            
            
        }
    }
    
//    I just commented these out because seeing errors in the compiler drives me nuts, once I get the other models built these next three lines can be uncommented
    
//    var relatedPeople: [Person]
//    var relatedObjects: [Object]
//    var relatedEvents: [Event]
}

struct Collection: Codable {
    var name: String
}
