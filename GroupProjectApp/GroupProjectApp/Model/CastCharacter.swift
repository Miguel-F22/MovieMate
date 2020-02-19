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

struct MovieCharacter: Codable, Hashable {
    static func == (lhs: MovieCharacter, rhs: MovieCharacter) -> Bool {
        let isSame = lhs.name == rhs.name && lhs.notes == rhs.notes
        return isSame
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        if let notes = notes {
            hasher.combine(notes)
        }
    }
    var name: String
    var origin: AMovie?
    var notes: String?
    var relatedObjects: [MovieObject]?
    var relatedCharacters: [MovieCharacter]?
    var relateEvents: [MovieEvent]?
    
    enum CodingKeys: String, CodingKey {
        case name = "character"
    }
}
