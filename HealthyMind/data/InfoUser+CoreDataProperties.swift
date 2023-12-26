//
//  InfoUser+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 26/12/2023.
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

}

extension InfoUser : Identifiable {

}
