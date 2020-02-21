//
//  Character+CoreDataProperties.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 2/21/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var characterRelatedCharacters: NSSet?
    @NSManaged public var characterRelatedEvents: NSSet?
    @NSManaged public var characterRelatedObjects: NSSet?
    @NSManaged public var origin: NSSet?

}

// MARK: Generated accessors for characterRelatedCharacters
extension Character {

    @objc(addCharacterRelatedCharactersObject:)
    @NSManaged public func addToCharacterRelatedCharacters(_ value: Character)

    @objc(removeCharacterRelatedCharactersObject:)
    @NSManaged public func removeFromCharacterRelatedCharacters(_ value: Character)

    @objc(addCharacterRelatedCharacters:)
    @NSManaged public func addToCharacterRelatedCharacters(_ values: NSSet)

    @objc(removeCharacterRelatedCharacters:)
    @NSManaged public func removeFromCharacterRelatedCharacters(_ values: NSSet)

}

// MARK: Generated accessors for characterRelatedEvents
extension Character {

    @objc(addCharacterRelatedEventsObject:)
    @NSManaged public func addToCharacterRelatedEvents(_ value: Event)

    @objc(removeCharacterRelatedEventsObject:)
    @NSManaged public func removeFromCharacterRelatedEvents(_ value: Event)

    @objc(addCharacterRelatedEvents:)
    @NSManaged public func addToCharacterRelatedEvents(_ values: NSSet)

    @objc(removeCharacterRelatedEvents:)
    @NSManaged public func removeFromCharacterRelatedEvents(_ values: NSSet)

}

// MARK: Generated accessors for characterRelatedObjects
extension Character {

    @objc(addCharacterRelatedObjectsObject:)
    @NSManaged public func addToCharacterRelatedObjects(_ value: Object)

    @objc(removeCharacterRelatedObjectsObject:)
    @NSManaged public func removeFromCharacterRelatedObjects(_ value: Object)

    @objc(addCharacterRelatedObjects:)
    @NSManaged public func addToCharacterRelatedObjects(_ values: NSSet)

    @objc(removeCharacterRelatedObjects:)
    @NSManaged public func removeFromCharacterRelatedObjects(_ values: NSSet)

}

// MARK: Generated accessors for origin
extension Character {

    @objc(addOriginObject:)
    @NSManaged public func addToOrigin(_ value: Movie)

    @objc(removeOriginObject:)
    @NSManaged public func removeFromOrigin(_ value: Movie)

    @objc(addOrigin:)
    @NSManaged public func addToOrigin(_ values: NSSet)

    @objc(removeOrigin:)
    @NSManaged public func removeFromOrigin(_ values: NSSet)

}
