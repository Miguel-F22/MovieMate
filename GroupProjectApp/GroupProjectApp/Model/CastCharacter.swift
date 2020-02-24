//
//  CastCharacter.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/21/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation

struct Cast: Codable {
    var cast: Array<MovieCharacter>
}

struct MovieCharacter: Codable {
    var name: String
    var notes: String?
    var relatedObjects: [MovieObject]?
    var relatedCharacters: [MovieCharacter]?
    var relateEvents: [MovieEvent]?
    
    enum CodingKeys: String, CodingKey {
        case name = "character"
    }
}
