//
//  CalendarWeek.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import Foundation

internal struct CalendarWeek: Hashable {
    var uuid: String
    var calendarDays: [CalendarDay]
    
    init(calendarDays: [CalendarDay]) {
        self.uuid = UUID().uuidString
        self.calendarDays = calendarDays
    }
    
    static func == (lhs: CalendarWeek, rhs: CalendarWeek) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
