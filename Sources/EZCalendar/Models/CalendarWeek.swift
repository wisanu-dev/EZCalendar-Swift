//
//  CalendarWeek.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import Foundation

public struct CalendarWeek: Hashable {
    public var uuid: String
    public var calendarDays: [CalendarDay]
    
    public init(calendarDays: [CalendarDay]) {
        self.uuid = UUID().uuidString
        self.calendarDays = calendarDays
    }
    
    public static func == (lhs: CalendarWeek, rhs: CalendarWeek) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
