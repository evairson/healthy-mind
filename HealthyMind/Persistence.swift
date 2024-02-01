//
//  Persistence.swift
//  HealthyMind
//
//  Created by Eva Herson on 19/12/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer
    
    func addBasicsTasks() {
        let context = self.container.viewContext
        let fetchRequest: NSFetchRequest<Task>=Task.fetchRequest()
        let infoUser: NSFetchRequest<InfoUser>=InfoUser.fetchRequest()
        
        
        do {
            let count = try context.count(for: fetchRequest)
            let count2 = try context.count(for: infoUser)
            if count == 0 {
                createInitialTasks()
            }
            if count2 == 0 {
                createUser()
            }
            try context.save()
        } catch {
            fatalError("Error : \(error)")
        }
    }
    
    func createInitialTasks(){
        let context = self.container.viewContext
        
        let counterId = CounterId(context: context)
        counterId.id = 0
        counterId.idHabits = 0
        
        let task1 = Task(context: context)
        task1.color = "task1"
        task1.title = "Mood"
        task1.icon = "taskImage2"
        let contain1 = TaskContain(context: context)
        contain1.title = "How are you feeling right now ?"
        contain1.num = 1
        contain1.isIcon = true
        contain1.listIcons = TaskContain.listIconOne
        let contain2 = TaskContain(context: context)
        contain2.title = "Can you tell us more ?"
        contain2.isText = true
        contain2.num = 2
        task1.id = counterId.id
        counterId.id += 1
        
        task1.addToContains(contain1)
        task1.addToContains(contain2)
        
        
        let task2 = Task(context: context)
        task2.color = "task2"
        task2.title = "Thanks for"
        task2.icon = "taskImage1"
        let contain12 = TaskContain(context: context)
        contain12.title = "First thing you are thanks for :"
        contain12.num = 1
        contain12.isText = true
        let contain22 = TaskContain(context: context)
        contain22.title = "second thing you are thanks for :"
        contain22.isText = true
        contain22.num = 2
        let contain32 = TaskContain(context: context)
        contain32.title = "third thing you are thanks for :"
        contain32.isText = true
        contain32.num = 3
        task2.id = counterId.id
        counterId.id += 1
        
        task2.addToContains(contain12)
        task2.addToContains(contain22)
        task2.addToContains(contain32)
        
        
        let habit1 = Habit(context: context)
        habit1.id = counterId.idHabits
        counterId.idHabits += 1
        habit1.title = "Drink Water"
        habit1.numberDay = 5
        habit1.numberNow = 5
        
        counterId.taskDay = Date()
        
    }

    private func createUser(){
        let context = self.container.viewContext
        
        let user = InfoUser(context: context)
        
        user.avatarList = 22
        user.avatar = 1
        user.foreName = "First Name"
        user.lastName = "Last Name"
        
    }
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "HealthyMind")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        addBasicsTasks()
    }
}
