//
//  File.swift
//  EZCalendar
//
//  Created by wisanu on 27/9/2568 BE.
//

import Foundation

public class CalendarEvent: Hashable {
    public var uuid = UUID().uuidString
    public var eventDate: Date
    
    public init(uuid: String = UUID().uuidString, eventDate: Date) {
        self.uuid = uuid
        self.eventDate = eventDate
    }
    
    public static func == (lhs: CalendarEvent, rhs: CalendarEvent) -> Bool {
        lhs.uuid == rhs.uuid && rhs.eventDate == lhs.eventDate
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine("\(uuid)\(eventDate.timeIntervalSince1970)")
    }
}

