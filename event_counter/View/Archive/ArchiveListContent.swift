//
//  ArchiveListContent.swift
//  event_counter
//
//  Created by Marek Walica on 12/03/2026.
//

import SwiftData
import SwiftUI

struct ArchiveListContent: View {

    private let selectedType: Type?

    @Environment(\.modelContext) var modelContext
    @Query private var events: [Event]

    init(selectedType: Type?) {
        self.selectedType = selectedType

        if let selectedType {
            let typeName = selectedType.name
            _events = Query(
                filter: #Predicate<Event> {
                    $0.type.name == typeName && $0.type.isArchive
                },
                sort: \Event.eventDate,
                order: .reverse
            )
        } else {
            _events = Query(
                filter: #Predicate<Event> {
                    $0.type.isArchive
                },
                sort: \Event.eventDate,
                order: .reverse
            )
        }
    }

    var body: some View {
        List {
            Section {
                HStack {
                    Text("\(selectedType?.name ?? "All archived events"): ")
                    Text("\(events.reduce(0) { $0 + $1.amount })")
                        .foregroundStyle(.blue)
                }
            }
            ForEach(events) { event in
                VStack {
                    HStack {
                        Text(event.amount, format: .number)
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(.teal.mix(with: .black, by: 0.2))
                            .clipShape(.circle)

                        Text(event.type.name)
                            .font(.headline)
                            .fontWeight(.regular)
                        Spacer()
                        Text(
                            event.eventDate,
                            format: .dateTime.year().month().day()
                        )
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    }

                    if event.desc != nil {
                        HStack {
                            Text(event.desc ?? "")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                    }

                }
                .contentShape(Rectangle())
            }
            .onDelete(perform: deleteEvent)
        }
        .overlay {
            if events.isEmpty {
                ContentUnavailableView(
                    "No archived events",
                    systemImage: "folder"
                )
            }
        }

    }

    private func deleteEvent(at offsets: IndexSet) {
        offsets.forEach { index in
            modelContext.delete(events[index])
        }
    }
}

//#Preview {
//    ArchiveListContent()
//}
