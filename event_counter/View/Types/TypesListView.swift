//
//  TypesListView.swift
//  event_counter
//
//  Created by Marek Walica on 25/02/2026.
//

import SwiftData
import SwiftUI

struct TypesListView: View {

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Type.name) private var types: [Type]

    @State private var showAddSheet = false
    @State private var typeToEdit: Type?

    @State private var typeToDelete: Type?
    @State private var showDeleteConfirmation = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(types) { type in
                    HStack {
                        Text(type.name)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        typeToEdit = type
                    }
                }
                .onDelete { offsets in
                    typeToDelete = types[offsets.first!]
                    showDeleteConfirmation = true
                }
            }
            .navigationTitle("Types")
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
                TypeFormView()
            }
            .sheet(item: $typeToEdit) { type in
                TypeFormView(type: type)
            }
            .confirmationDialog(
                "Do you want delete this type?",
                isPresented: $showDeleteConfirmation,
                titleVisibility: .visible
            ) {
                Button("Delete", role: .destructive) {
                    if let type = typeToDelete {
                        modelContext.delete(type)
                        typeToDelete = nil
                    }
                }

                Button("Cancel", role: .cancel) {
                    typeToDelete = nil
                }
            }

            .overlay {
                if types.isEmpty {
                    ContentUnavailableView(
                        "No defined types",
                        systemImage: "folder",
                        description: Text("Please add first type")
                    )
                }
            }
        }
    }
}

//#Preview {
//    TypesListView()
//}
