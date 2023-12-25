//
//  Task+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 25/12/2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var color: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var contains: NSSet?

}

// MARK: Generated accessors for contains
extension Task {

    @objc(addContainsObject:)
    @NSManaged public func addToContains(_ value: TaskContain)

    @objc(removeContainsObject:)
    @NSManaged public func removeFromContains(_ value: TaskContain)

    @objc(addContains:)
    @NSManaged public func addToContains(_ values: NSSet)

    @objc(removeContains:)
    @NSManaged public func removeFromContains(_ values: NSSet)

}

extension Task : Identifiable {

}
