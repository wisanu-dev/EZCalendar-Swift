//
//  CalendarMonth.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import Foundation

public struct CalendarMonth: Hashable {
    
    public let uuid = UUID().uuidString
    public let month: Int
    public let year: Int
    public var events: [CalendarEvent]
    
    var hashString: String {
        "\(uuid)\(events.count)"
    }

    public init(month: Int, year: Int, events: [CalendarEvent] = []) {
        self.month = month
        self.year = year
        self.events = events
    }
    
    public static func == (lhs: CalendarMonth, rhs: CalendarMonth) -> Bool {
        lhs.uuid == rhs.uuid && rhs.events == lhs.events
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(hashString)
    }
    
}
