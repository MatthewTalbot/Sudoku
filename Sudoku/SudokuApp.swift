//
//  SudokuApp.swift
//  Sudoku
//
//  Created by Matthew Talbot on 2021-05-10.
//

import SwiftUI

@main
struct SudokuApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
