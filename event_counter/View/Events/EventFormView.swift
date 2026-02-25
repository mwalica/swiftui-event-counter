//
//  EventFormView.swift
//  event_counter
//
//  Created by Marek Walica on 25/02/2026.
//

import SwiftData
import SwiftUI

struct EventFormView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Type.name) private var types: [Type]

    var event: Event?

    @State private var selectedType: Type?
    @State private var eventDate: Date = .now
    @State private var amount: Int = 1
    @State private var desc: String = ""

    private var isEditing: Bool {
        event != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Event") {
                    Picker("Event Type", selection: $selectedType) {
                        Text("Brak").tag(Optional<Type>.none)
                        ForEach(types) { type in
                            Text(type.name).tag(Optional(type))
                        }
                    }
                    .pickerStyle(.menu)

                    DatePicker(
                        "Date",
                        selection: $eventDate,
                        displayedComponents: .date
                    )
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.numberPad)
                    TextField("Description", text: $desc, axis: .vertical)
                        .lineLimit(2...4)

                }
            }
            .navigationTitle(isEditing ? "Edit Event" : "Add Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        save()
                    }
                    .disabled(selectedType == nil || amount < 1)
                }
            }
            .onAppear {
                loadEvent()
            }
        }
    }

    private func loadEvent() {
        guard let event else { return }
        selectedType = event.type
        eventDate = event.eventDate
        amount = event.amount
        desc = event.desc ?? ""
    }

    private func save() {
        if let event {
            event.type = selectedType!
            event.eventDate = eventDate
            event.amount = amount
            event.desc = desc.isEmpty ? nil : desc

        } else {
            let newEvent = Event(
                type: selectedType!,
                eventDate: eventDate,
                amount: amount,
                desc: desc.isEmpty ? nil : desc
            )
            context.insert(newEvent)
        }
        dismiss()
    }
}

//#Preview {
//    EventFormView()
//}
