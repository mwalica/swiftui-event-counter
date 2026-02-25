//
//  event_counterApp.swift
//  event_counter
//
//  Created by Marek Walica on 25/02/2026.
//

import SwiftUI
import SwiftData

@main
struct event_counterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Event.self, Type.self])
    }
}
