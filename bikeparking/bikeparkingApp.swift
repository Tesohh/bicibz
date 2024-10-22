//
//  bikeparkingApp.swift
//  bikeparking
//
//  Created by Simone Tesini on 19/10/24.
//

import SwiftUI
import SwiftData

@main
struct bikeparkingApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ParkingSpot.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MapView()
        }
        .modelContainer(sharedModelContainer)
    }
}
