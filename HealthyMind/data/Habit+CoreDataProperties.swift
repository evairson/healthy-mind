//
//  Habit+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 22/01/2024.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var id: Int64
    @NSManaged public var numberDay: Int64
    @NSManaged public var numberNow: Int64
    @NSManaged public var title: String?
    @NSManaged public var color: String?

}

extension Habit : Identifiable {

}
