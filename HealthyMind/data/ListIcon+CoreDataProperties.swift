//
//  ListIcon+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 25/12/2023.
//
//

import Foundation
import CoreData


extension ListIcon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListIcon> {
        return NSFetchRequest<ListIcon>(entityName: "ListIcon")
    }

    @NSManaged public var icon: [Int]?
    @NSManaged public var taskContain: NSSet?

}

// MARK: Generated accessors for taskContain
extension ListIcon {

    @objc(addTaskContainObject:)
    @NSManaged public func addToTaskContain(_ value: TaskContain)

    @objc(removeTaskContainObject:)
    @NSManaged public func removeFromTaskContain(_ value: TaskContain)

    @objc(addTaskContain:)
    @NSManaged public func addToTaskContain(_ values: NSSet)

    @objc(removeTaskContain:)
    @NSManaged public func removeFromTaskContain(_ values: NSSet)

}

extension ListIcon : Identifiable {

}
