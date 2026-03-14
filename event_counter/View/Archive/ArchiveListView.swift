//
//  ArchiveListView.swift
//  event_counter
//
//  Created by Marek Walica on 05/03/2026.
//

import SwiftData
import SwiftUI

struct ArchiveListView: View {

    @Query(filter: #Predicate<Type> { $0.isArchive }, sort: \Type.name) private
        var types: [Type]
    @State private var eventToEdit: Event?
    @State private var selectedType: Type? = nil

    var body: some View {
        NavigationStack {
            ArchiveListContent(
                selectedType: selectedType,
            )
            .navigationTitle("Archived Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu("Filter", systemImage: "line.3.horizontal.decrease") {
                        Picker("Filter", selection: $selectedType) {
                            Text("All").tag(Optional<Type>.none)
                            ForEach(types) { type in
                                Text("\(type.name)")
                                    .tag(Optional(type))
                            }
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }
}

//#Preview {
//    ArchiveListView()
//}
