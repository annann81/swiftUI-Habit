//
//  HabitApp.swift
//  Habit
//
//  Created by A2006 on 2021/8/13.
//

import SwiftUI

@main
struct HabitApp: App {
    
    @StateObject private var store = SelectSymbolsName()
//    @StateObject private var store2 = TotlAwardNum()
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
//                .environmentObject(store2)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
