//
//  TaskContain+CoreDataProperties.swift
//  HealthyMind
//
//  Created by Eva Herson on 29/12/2023.
//
//

import Foundation
import CoreData


extension TaskContain {
    
    static let listIconOne = [1,2,3,4,5]
    
    public func copy(context : NSManagedObjectContext) -> TaskContain {
        let contain = TaskContain(context: context)
        contain.isText = self.isText
        contain.num = self.num
        contain.textAnswer = self.textAnswer
        contain.title = self.title
        contain.iconAnswer = self.iconAnswer
        contain.isIcon = self.isIcon
        contain.listIcons = self.listIcons
        return contain
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskContain> {
        return NSFetchRequest<TaskContain>(entityName: "TaskContain")
    }

    @NSManaged public var iconAnswer: String?
    @NSManaged public var isIcon: Bool
    @NSManaged public var isText: Bool
    @NSManaged public var num: Int64
    @NSManaged public var textAnswer: String?
    @NSManaged public var title: String?
    @NSManaged public var listIcons: [Int]?
    @NSManaged public var answer: Answer?
    @NSManaged public var taskOk: Task?

}

extension TaskContain : Identifiable {

}
