//
//  Shopping_ListApp.swift
//  Shopping List
//
//  Created by Andreas Zikovic on 2024-04-29.
//

import SwiftUI

@main
struct Shopping_ListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
