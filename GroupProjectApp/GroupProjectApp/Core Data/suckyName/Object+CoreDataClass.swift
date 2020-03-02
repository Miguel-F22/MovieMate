//
//  Object+CoreDataClass.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 3/2/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Object)
public class Object: Movie {
    convenience init(movieObject: MovieObject, context: NSManagedObjectContext = PersistenceService.context) {
        
        self.init(context: context)
        
        name = movieObject.name
        notes = movieObject.notes
        characters = movieObject.relatedCharacters
        objects = movieObject.relatedObjects
        events = movieObject.relateEvents
    }
}
