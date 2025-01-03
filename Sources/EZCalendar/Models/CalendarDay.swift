//
//  CalendarDay.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import Foundation

public struct CalendarDay: Hashable {
    public let day: Int?
    public let date: Date?
    public let isCurrentMonth: Bool
    
    init () {
        self.day = nil
        self.date = nil
        self.isCurrentMonth = false
    }
    
    init(day: Int?, date: Date?, isCurrentMonth: Bool = true) {
        self.day = day
        self.date = date
        self.isCurrentMonth = isCurrentMonth
    }
    
    public static func == (lhs: CalendarDay, rhs: CalendarDay) -> Bool {
        lhs.date == rhs.date
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}
