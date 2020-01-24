//
//  File.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/21/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation

struct Object: Codable {
    var name: String
    var origin: Movie?
    var notes: String?
    var relatedObjects: [Object]?
    var relatedCharacters: [Character]?
    var relatedEvent: [Event]?
}
