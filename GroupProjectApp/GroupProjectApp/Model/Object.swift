//
//  File.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/21/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation

struct MovieObject: Codable {
    var name: String
    var origin: AMovie?
    var notes: String?
    var relatedObjects: [MovieObject]?
    var relatedCharacters: [MovieCharacter]?
    var relatedEvent: [MovieEvent]?
}
