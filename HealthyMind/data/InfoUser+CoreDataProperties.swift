//
//  InfoUser+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 27/12/2023.
//
//

import Foundation
import CoreData


extension InfoUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InfoUser> {
        return NSFetchRequest<InfoUser>(entityName: "InfoUser")
    }

    @NSManaged public var foreName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var avatar: Int64
    @NSManaged public var avatarList: Int64

}

extension InfoUser : Identifiable {

}
