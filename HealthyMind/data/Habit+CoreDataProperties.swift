//
//  Habit+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 02/01/2024.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var name: String?
    @NSManaged public var numberDay: Int64
    @NSManaged public var numberNow: Int64

}

extension Habit : Identifiable {

}
