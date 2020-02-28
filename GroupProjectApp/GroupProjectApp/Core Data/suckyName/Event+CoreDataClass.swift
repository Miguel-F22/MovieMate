//
//  Event+CoreDataClass.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 2/24/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Event)
public class Event: Movie {
    convenience init(movieEvent: MovieEvent, context: NSManagedObjectContext = PersistenceService.context) {
        self.init(context: context)
        
        self.name = movieEvent.name
        self.notes = movieEvent.notes
        characters = movieEvent.relatedCharacters
        objects = movieEvent.relatedObjects
        events = movieEvent.relateEvents
    }
}
