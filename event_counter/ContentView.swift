//
//  ContentView.swift
//  event_counter
//
//  Created by Marek Walica on 25/02/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EventsListView()
                .tabItem {
                    Label("Events", systemImage: "list.bullet")
                }
            TypesListView()
                .tabItem {
                    Label("Types", systemImage: "square.grid.2x2")
                }
            ArchiveListView()
                .tabItem {
                    Label("Archive", systemImage: "archivebox")
                }
        }
    }
}

#Preview {
    ContentView()
}
