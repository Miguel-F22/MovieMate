//
//  Character+CoreDataClass.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 2/24/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Character)
public class Character: Movie {
    convenience init(movieCharacter: MovieCharacter, context: NSManagedObjectContext = PersistenceService.context) {
        self.init(context: context)
        
        name = movieCharacter.name
        notes = movieCharacter.notes
        characters = movieCharacter.relatedCharacters
        objects = movieCharacter.relatedObjects
        events = movieCharacter.relateEvents
    }
}
