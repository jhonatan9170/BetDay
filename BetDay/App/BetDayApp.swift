//
//  BetDayApp.swift
//  BetDay
//
//  Created by Jhonatan Chavez  on 18/03/26.
//

import SwiftUI
import SwiftData

@main
struct BetDayLiteApp: App {

    let modelContainer: ModelContainer = {
        let schema = Schema([PlacedBetData.self])
        let config = ModelConfiguration(schema: schema)
        do {
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("SwiftData failed to initialize: \(error)")
        }
    }()

    init() {
        DependencyContainer.shared = DependencyContainer(
            modelContext: modelContainer.mainContext
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
