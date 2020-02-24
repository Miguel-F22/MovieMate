//
//  Event+CoreDataProperties.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 2/21/20.
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
    @NSManaged public var eventRelatedCharacters: NSSet?
    @NSManaged public var eventRelatedEvents: NSSet?
    @NSManaged public var eventRelatedObjects: NSSet?

}

// MARK: Generated accessors for eventRelatedCharacters
extension Event {

    @objc(addEventRelatedCharactersObject:)
    @NSManaged public func addToEventRelatedCharacters(_ value: Character)

    @objc(removeEventRelatedCharactersObject:)
    @NSManaged public func removeFromEventRelatedCharacters(_ value: Character)

    @objc(addEventRelatedCharacters:)
    @NSManaged public func addToEventRelatedCharacters(_ values: NSSet)

    @objc(removeEventRelatedCharacters:)
    @NSManaged public func removeFromEventRelatedCharacters(_ values: NSSet)

}

// MARK: Generated accessors for eventRelatedEvents
extension Event {

    @objc(addEventRelatedEventsObject:)
    @NSManaged public func addToEventRelatedEvents(_ value: Event)

    @objc(removeEventRelatedEventsObject:)
    @NSManaged public func removeFromEventRelatedEvents(_ value: Event)

    @objc(addEventRelatedEvents:)
    @NSManaged public func addToEventRelatedEvents(_ values: NSSet)

    @objc(removeEventRelatedEvents:)
    @NSManaged public func removeFromEventRelatedEvents(_ values: NSSet)

}

// MARK: Generated accessors for eventRelatedObjects
extension Event {

    @objc(addEventRelatedObjectsObject:)
    @NSManaged public func addToEventRelatedObjects(_ value: Object)

    @objc(removeEventRelatedObjectsObject:)
    @NSManaged public func removeFromEventRelatedObjects(_ value: Object)

    @objc(addEventRelatedObjects:)
    @NSManaged public func addToEventRelatedObjects(_ values: NSSet)

    @objc(removeEventRelatedObjects:)
    @NSManaged public func removeFromEventRelatedObjects(_ values: NSSet)

}

// MARK: Generated accessors for origin
extension Event {

    @objc(addOriginObject:)
    @NSManaged public func addToOrigin(_ value: Movie)

    @objc(removeOriginObject:)
    @NSManaged public func removeFromOrigin(_ value: Movie)

    @objc(addOrigin:)
    @NSManaged public func addToOrigin(_ values: NSSet)

    @objc(removeOrigin:)
    @NSManaged public func removeFromOrigin(_ values: NSSet)

}
