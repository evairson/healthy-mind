//
//  InfoUser+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 04/02/2024.
//
//

import Foundation
import CoreData


extension InfoUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InfoUser> {
        return NSFetchRequest<InfoUser>(entityName: "InfoUser")
    }

    @NSManaged public var avatar: Int64
    @NSManaged public var avatarList: Int64
    @NSManaged public var foreName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var tuto: Bool

}

extension InfoUser : Identifiable {

}
