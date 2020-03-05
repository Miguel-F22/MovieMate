//
//  MoObject+CoreDataProperties.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 3/2/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//
//

import Foundation
import CoreData

extension MoObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoObject> {
        return NSFetchRequest<MoObject>(entityName: "MoObject")
    }

    @NSManaged public var characters: String?
    @NSManaged public var events: String?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var objects: String?
    @NSManaged public var parentMovie: Movie?

}
