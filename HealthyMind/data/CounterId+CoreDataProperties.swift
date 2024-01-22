//
//  CounterId+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 02/01/2024.
//
//

import Foundation
import CoreData


extension CounterId {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CounterId> {
        return NSFetchRequest<CounterId>(entityName: "CounterId")
    }

    @NSManaged public var id: Int64
    @NSManaged public var idHabits: Int64
    @NSManaged public var taskDay: Date?

}

extension CounterId : Identifiable {

}
