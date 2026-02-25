//
//  Event.swift
//  event_counter
//
//  Created by Marek Walica on 25/02/2026.
//

import Foundation
import SwiftData

@Model
class Event {
    var type: Type
    var eventDate: Date
    var amount: Int
    var description: String?

    init(type: Type, eventDate: Date, amount: Int, description: String? = nil) {
        self.type = type
        self.eventDate = eventDate
        self.amount = amount
        self.description = description
    }
}
