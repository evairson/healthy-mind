//
//  CounterId+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 25/12/2023.
//
//

import Foundation
import CoreData


extension CounterId {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CounterId> {
        return NSFetchRequest<CounterId>(entityName: "CounterId")
    }

    @NSManaged public var id: Int64

}

extension CounterId : Identifiable {

}
