//
//  TypeFormView.swift
//  event_counter
//
//  Created by Marek Walica on 25/02/2026.
//

import SwiftData
import SwiftUI

struct TypeFormView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Type.name) private var types: [Type]

    var type: Type?

    @State private var name = ""
    @State private var isArchive = false

    private var isEditing: Bool {
        type != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Type name") {
                    TextField("type name", text: $name)
                    if isEditing {
                        Toggle(isOn: $isArchive) {
                            Label("Archived", systemImage: "archivebox")
                        }
                        .toggleStyle(.switch)
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Type" : "Add Type")
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
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear {
                name = type?.name ?? ""
                isArchive = type?.isArchive ?? false
            }
        }
    }

    private func save() {
        if let type {
            type.name = name.trimmingCharacters(in: .whitespaces)
            type.isArchive = isArchive
        } else {
            modelContext.insert(
                Type(
                    name: name.trimmingCharacters(in: .whitespaces),
                )
            )
        }
        dismiss()
    }
}

//#Preview {
//    TypeFormView()
//}
