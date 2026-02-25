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
    var archive: Bool = false
    @Relationship(deleteRule: .cascade, inverse: \Event.type)
    var events: [Event]?
    
    init (name: String) {
        self.name = name
    }
}
