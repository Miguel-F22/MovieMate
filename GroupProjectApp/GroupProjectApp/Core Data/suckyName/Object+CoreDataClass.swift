//
//  Object+CoreDataClass.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 2/21/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Object)
public class Object: Movie {
    
    convenience init(movieObject: MovieObject, context: NSManagedObjectContext = PersistenceService.context) {
        
        self.init(context: context)
        
        self.name = movieObject.name
        self.notes = movieObject.notes
        self.objectRelatedCharacters = NSSet(array: movieObject.relatedCharacters ?? [] )
        self.objectRelatedEvents = NSSet(array: movieObject.relatedEvents ?? [] )
        self.objectRelatedObjects = NSSet(array: movieObject.relatedObjects ?? [] )
    }

}
