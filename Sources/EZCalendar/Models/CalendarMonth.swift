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
    
    public init(month: Int, year: Int) {
        self.month = month
        self.year = year
    }
}
