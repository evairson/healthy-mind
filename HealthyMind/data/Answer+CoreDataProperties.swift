//
//  Answer+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 25/12/2023.
//
//

import Foundation
import CoreData


extension Answer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer")
    }

    @NSManaged public var day: Int64
    @NSManaged public var month: Int64
    @NSManaged public var year: Int64
    @NSManaged public var title: String?
    @NSManaged public var icon: String?
    @NSManaged public var color: String?
    @NSManaged public var contains: NSSet?

}

// MARK: Generated accessors for contains
extension Answer {

    @objc(addContainsObject:)
    @NSManaged public func addToContains(_ value: TaskContain)

    @objc(removeContainsObject:)
    @NSManaged public func removeFromContains(_ value: TaskContain)

    @objc(addContains:)
    @NSManaged public func addToContains(_ values: NSSet)

    @objc(removeContains:)
    @NSManaged public func removeFromContains(_ values: NSSet)

}

extension Answer : Identifiable {

}
