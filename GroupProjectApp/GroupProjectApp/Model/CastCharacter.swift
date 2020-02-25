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

struct MovieCharacter: Codable, Equatable {
    static func == (lhs: MovieCharacter, rhs: MovieCharacter) -> Bool {
        return lhs.name == rhs.name
    }
    var name: String
    var notes: String?
    var relatedObjects: String?
    var relatedCharacters: String?
    var relateEvents: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "character"
    }
}
