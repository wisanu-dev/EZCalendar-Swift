//
//  CalendarDay.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import Foundation

public struct CalendarDay: Hashable {

    public let date: Date?
    public let isCurrentMonth: Bool
    public let hasEvents: Bool
    
    init () {
        self.date = nil
        self.isCurrentMonth = false
        self.hasEvents = false
    }
    
    init(date: Date?, isCurrentMonth: Bool = true, hasEvents: Bool = false) {
        self.date = date
        self.isCurrentMonth = isCurrentMonth
        self.hasEvents = hasEvents
    }
    
    public static func == (lhs: CalendarDay, rhs: CalendarDay) -> Bool {
        lhs.date == rhs.date && lhs.isCurrentMonth == rhs.isCurrentMonth && lhs.hasEvents == rhs.hasEvents
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine("\(date?.timeIntervalSince1970 ?? 0)\(isCurrentMonth)\(hasEvents)")
    }
}
