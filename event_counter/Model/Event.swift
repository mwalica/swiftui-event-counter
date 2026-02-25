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
    var desc: String?

    init(type: Type, eventDate: Date, amount: Int, desc: String? = nil) {
        self.type = type
        self.eventDate = eventDate
        self.amount = amount
        self.desc = desc
    }
}
