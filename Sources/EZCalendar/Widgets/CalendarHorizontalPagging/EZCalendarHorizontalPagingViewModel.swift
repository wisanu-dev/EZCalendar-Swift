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
    var startDate: Date
    var endDate: Date
    var calendarMonths: [CalendarMonth] = []
    
    public init(_ calendar: Calendar, startDate: Date, endDate: Date) {
        self.calendar = calendar
        self.startDate = startDate
        self.endDate = endDate
        self.generateCalendarMonths()
        debugPrint("init CalendarPagingViewModel")
    }
    
    private func generateCalendarMonths() {
        self.calendarMonths = []
        
        var currentFirstDateOfMonth = startDate.startOfMonth
        
        while currentFirstDateOfMonth <= endDate {
            
            let calendarComponents = calendar.dateComponents([.month, .year], from: currentFirstDateOfMonth)
            
            guard let year = calendarComponents.year, let month = calendarComponents.month else {
                break
            }
            
            self.calendarMonths.append(
                CalendarMonth(month: month, year: year)
            )
            
            guard let nextFirstDateOfMonth = currentFirstDateOfMonth.addingComponentsOfDate(month: 1) else {
                break
            }
            
            currentFirstDateOfMonth = nextFirstDateOfMonth
        }
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
