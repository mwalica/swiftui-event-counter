//
//  EventsListView.swift
//  event_counter
//
//  Created by Marek Walica on 25/02/2026.
//

import SwiftData
import SwiftUI

struct EventsListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Event.eventDate, order: .reverse) private var events: [Event]

    @State private var showAddSheet = false
    @State private var eventToEdit: Event?

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("All events:")
                        Text("\(events.count)")
                            .foregroundStyle(.blue)
                    }
                }
                ForEach(events) { event in
                    VStack {
                        HStack {
                            Text(event.amount, format: .number)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            Text(event.type.name)
                                .font(.headline)
                                .fontWeight(.medium)
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
                                    .offset(x: 14)
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
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddSheet) {
                EventFormView()
            }
            .sheet(item: $eventToEdit) { event in
                EventFormView(event: event)
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
    }
    private func deleteEvent(at offsets: IndexSet) {
        offsets.forEach {
            context.delete(events[$0])
        }
    }
}

#Preview {
    EventsListView()
}
