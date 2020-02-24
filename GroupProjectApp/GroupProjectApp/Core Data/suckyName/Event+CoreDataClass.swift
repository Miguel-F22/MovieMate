//
//  Event+CoreDataClass.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 2/21/20.
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
        self.eventRelatedCharacters = NSSet(array: movieEvent.relatedCharacters ?? [] )
        self.eventRelatedEvents = NSSet(array: movieEvent.relatedEvents ?? [] )
        self.eventRelatedObjects = NSSet(array: movieEvent.relatedObjects ?? [] )
    }

}
