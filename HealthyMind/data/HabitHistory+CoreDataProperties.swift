//
//  HabitHistory+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 05/02/2024.
//
//

import Foundation
import CoreData


extension HabitHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitHistory> {
        return NSFetchRequest<HabitHistory>(entityName: "HabitHistory")
    }

    @NSManaged public var day: Int64
    @NSManaged public var month: Int64
    @NSManaged public var numberDone: Int64
    @NSManaged public var year: Int64
    @NSManaged public var habit: Habit?

}

extension HabitHistory : Identifiable {

}
