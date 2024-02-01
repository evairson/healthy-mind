//
//  HealthyMindApp.swift
//  HealthyMind
//
//  Created by Eva Herson on 19/12/2023.
//

import SwiftUI

@main
struct HealthyMindApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
