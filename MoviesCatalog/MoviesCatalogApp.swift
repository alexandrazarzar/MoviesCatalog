//
//  MoviesCatalogApp.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import SwiftUI
import SwiftData

@main
struct MoviesCatalogApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: WatchedMovie.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
