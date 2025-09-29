//
//  EZCalendarHorizontalPagingViewModel.swift
//  MyCalendarComponent
//
//  Created by Wisanu Paunglumjeak on 16/12/2567 BE.
//

import SwiftUI
import Combine

public class EZCalendarHorizontalPagingViewModel: ObservableObject {
    
    var calendar: Calendar
    
    @Published var activeCalendarMonthUUID: String? = nil
    @Binding public var currentMonth: Date
    @Binding public var calendarMonths: [CalendarMonth]
    
    public init(calendar: Calendar = .current, activeCalendarMonthUUID: String? = nil, currentMonth: Binding<Date>, calendarMonths: Binding<[CalendarMonth]>) {
        self.calendar = calendar
        self.activeCalendarMonthUUID = activeCalendarMonthUUID
        self._currentMonth = currentMonth
        self._calendarMonths = calendarMonths
    }

    func getCalendarMonth(fromDate date: Date) -> CalendarMonth? {
        let components = calendar.dateComponents([.month, .year], from: date)
        
        guard let calendarMonth = self.calendarMonths.first(where: {
            $0.year == components.year && $0.month == components.month
        }) else {
            return nil
        }
        
        return calendarMonth
    }
    
    func getCurrentMonth(fromUUID uuid: String?) -> Date? {
        
        guard let calendarMonth = calendarMonths.first(where: { $0.uuid == uuid }) else {
            return nil
        }
        
        
        return Date.from(year: calendarMonth.year, month: calendarMonth.month, day: 1, calendar: calendar)
    }
}
