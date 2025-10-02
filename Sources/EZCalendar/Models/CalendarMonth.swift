//
//  CalendarMonth.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import Foundation

public struct CalendarMonth: Hashable {
    
    public let month: Int
    public let year: Int
    public let events: [CalendarEvent]
    
    public var hashString: String {
        "\(hashValue)"
    }
    
    public init(month: Int, year: Int, events: [CalendarEvent] = []) {
        self.month = month
        self.year = year
        self.events = events
    }
}
