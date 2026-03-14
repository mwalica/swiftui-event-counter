//
//  EventsListContent.swift
//  event_counter
//
//  Created by Marek Walica on 26/02/2026.
//

import SwiftData
import SwiftUI

struct EventsListContent: View {

    private let selectedType: Type?

    @Environment(\.modelContext) var modelContext
    @Query private var events: [Event]
    @Binding var eventToEdit: Event?

    init(selectedType: Type?, eventToEdit: Binding<Event?>) {
        self.selectedType = selectedType
        _eventToEdit = eventToEdit

        if let selectedType {
            let typeName = selectedType.name
            _events = Query(
                filter: #Predicate<Event> {
                    $0.type.name == typeName && !$0.type.isArchive
                },
                sort: \Event.eventDate,
                order: .reverse
            )
        } else {
            _events = Query(
                filter: #Predicate<Event> { !$0.type.isArchive },
                sort: \Event.eventDate,
                order: .reverse
            )
        }
    }

    var body: some View {
        List {
            Section {
                HStack {
                    Text("\(selectedType?.name ?? "All events"): ")
                    Text("\(events.reduce(0){$0 + $1.amount})")
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
                .onTapGesture {
                    eventToEdit = event
                }
            }
            .onDelete(perform: deleteEvent)
        }
        .overlay {
            if events.isEmpty {
                ContentUnavailableView(
                    "No events",
                    systemImage: "folder",
                    description: Text("Please add first event")
                )
            }
        }
    }

    private func deleteEvent(at offsets: IndexSet) {
        offsets.forEach {
            modelContext.delete(events[$0])
        }
    }
}

//#Preview {
//    EventsListContent()
//}
