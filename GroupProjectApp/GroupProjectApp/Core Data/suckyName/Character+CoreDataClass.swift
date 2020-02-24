//
//  Character+CoreDataClass.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 2/21/20.
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
        self.characterRelatedCharacters = NSSet(array: movieCharacter.relatedCharacters ?? [] )
        self.characterRelatedEvents = NSSet(array: movieCharacter.relateEvents ?? [] )
        self.characterRelatedObjects = NSSet(array: movieCharacter.relatedObjects ?? [] )
        
        
    }

}
