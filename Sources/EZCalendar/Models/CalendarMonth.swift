//
//  CalendarMonth.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import Foundation

internal struct CalendarMonth: Hashable {
    let uuid = UUID().uuidString
    let month: Int
    let year: Int
}
