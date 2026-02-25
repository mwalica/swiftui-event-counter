//
//  Type.swift
//  event_counter
//
//  Created by Marek Walica on 25/02/2026.
//

import Foundation
import SwiftData

@Model
class Type {
    var name: String
    var isArchive: Bool
    @Relationship(deleteRule: .cascade, inverse: \Event.type)
    var events: [Event]?

    init(name: String, isArchive: Bool = false) {
        self.name = name
        self.isArchive = isArchive
    }
}
