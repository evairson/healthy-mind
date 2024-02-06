//
//  Habit+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 05/02/2024.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var color: String?
    @NSManaged public var id: Int64
    @NSManaged public var numberDay: Int64
    @NSManaged public var numberNow: Int64
    @NSManaged public var title: String?
    @NSManaged public var habitHistory: NSSet?

}

// MARK: Generated accessors for habitHistory
extension Habit {

    @objc(addHabitHistoryObject:)
    @NSManaged public func addToHabitHistory(_ value: HabitHistory)

    @objc(removeHabitHistoryObject:)
    @NSManaged public func removeFromHabitHistory(_ value: HabitHistory)

    @objc(addHabitHistory:)
    @NSManaged public func addToHabitHistory(_ values: NSSet)

    @objc(removeHabitHistory:)
    @NSManaged public func removeFromHabitHistory(_ values: NSSet)

}

extension Habit : Identifiable {

}
