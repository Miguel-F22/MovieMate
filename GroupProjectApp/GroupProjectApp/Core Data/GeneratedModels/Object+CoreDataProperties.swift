//
//  Object+CoreDataProperties.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 2/19/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData


extension Object {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Object> {
        return NSFetchRequest<Object>(entityName: "Object")
    }

    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var objectRelatedCharacters: NSSet?
    @NSManaged public var objectRelatedEvents: NSSet?
    @NSManaged public var objectRelatedObjects: NSSet?
    @NSManaged public var origin: NSSet?

}

// MARK: Generated accessors for objectRelatedCharacters
extension Object {

    @objc(addObjectRelatedCharactersObject:)
    @NSManaged public func addToObjectRelatedCharacters(_ value: Character)

    @objc(removeObjectRelatedCharactersObject:)
    @NSManaged public func removeFromObjectRelatedCharacters(_ value: Character)

    @objc(addObjectRelatedCharacters:)
    @NSManaged public func addToObjectRelatedCharacters(_ values: NSSet)

    @objc(removeObjectRelatedCharacters:)
    @NSManaged public func removeFromObjectRelatedCharacters(_ values: NSSet)

}

// MARK: Generated accessors for objectRelatedEvents
extension Object {

    @objc(addObjectRelatedEventsObject:)
    @NSManaged public func addToObjectRelatedEvents(_ value: Event)

    @objc(removeObjectRelatedEventsObject:)
    @NSManaged public func removeFromObjectRelatedEvents(_ value: Event)

    @objc(addObjectRelatedEvents:)
    @NSManaged public func addToObjectRelatedEvents(_ values: NSSet)

    @objc(removeObjectRelatedEvents:)
    @NSManaged public func removeFromObjectRelatedEvents(_ values: NSSet)

}

// MARK: Generated accessors for objectRelatedObjects
extension Object {

    @objc(addObjectRelatedObjectsObject:)
    @NSManaged public func addToObjectRelatedObjects(_ value: Object)

    @objc(removeObjectRelatedObjectsObject:)
    @NSManaged public func removeFromObjectRelatedObjects(_ value: Object)

    @objc(addObjectRelatedObjects:)
    @NSManaged public func addToObjectRelatedObjects(_ values: NSSet)

    @objc(removeObjectRelatedObjects:)
    @NSManaged public func removeFromObjectRelatedObjects(_ values: NSSet)

}

// MARK: Generated accessors for origin
extension Object {

    @objc(addOriginObject:)
    @NSManaged public func addToOrigin(_ value: Movie)

    @objc(removeOriginObject:)
    @NSManaged public func removeFromOrigin(_ value: Movie)

    @objc(addOrigin:)
    @NSManaged public func addToOrigin(_ values: NSSet)

    @objc(removeOrigin:)
    @NSManaged public func removeFromOrigin(_ values: NSSet)

}
