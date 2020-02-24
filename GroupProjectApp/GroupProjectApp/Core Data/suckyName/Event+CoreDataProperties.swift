//
//  Event+CoreDataProperties.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 2/24/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var characters: String?
    @NSManaged public var events: String?
    @NSManaged public var objects: String?
    @NSManaged public var parentMovie: Movie?

}
