//
//  EZCalendarItemViewModel.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import Foundation
import SwiftUI

class EZCalendarItemViewModel: ObservableObject {
    
    var calendar: Calendar
    @Published var calendarMonth: CalendarMonth
    @Published var calendarWeeks: [CalendarWeek] = []
    
    init(calendarMonth: CalendarMonth, calendar: Calendar) {
        self.calendarMonth = calendarMonth
        self.calendar = calendar
        self.calendarWeeks = self.generateCalendar()
    }
    
    private func generateCalendar() -> [CalendarWeek] {
        
        guard let firstDateOfMonth = Date.from(year: calendarMonth.year, month: calendarMonth.month, day: 1, calendar: calendar) else {
            return []
        }
        
        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: firstDateOfMonth)?.count else {
            return []
        }
        
        guard let lastDateOfMonth = Date.from(year: calendarMonth.year, month: calendarMonth.month, day: numberOfDaysInMonth, calendar: calendar) else {
            return []
        }
        
        guard let firstDayOfWeekInMonth = calendar.dateComponents([.weekday], from: firstDateOfMonth).weekday else {
            return []
        }
        
        guard let lastDayOfWeekInMonth = calendar.dateComponents([.weekday], from: lastDateOfMonth).weekday else {
            return []
        }
        
        var calendarWeeks: [CalendarWeek] = []
        var dayOfMonth = 1
        
        while dayOfMonth <= numberOfDaysInMonth {
            var calendarDays: [CalendarDay] = []
            
            for weekDay in 1...7 {
                if calendarWeeks.isEmpty {
                    /* If first week of month */
                    if weekDay >= firstDayOfWeekInMonth {
                        /* If first day of week in month in range*/
                        calendarDays.append(
                            self.buildCalendarDayInCurrentMonth(dayOfMonth)
                        )
                        dayOfMonth += 1
                    } else {
                        let diffDay = weekDay - firstDayOfWeekInMonth
                        calendarDays.append(
                            self.buildCalendarDayInPreviousMonth(startDateOfMonth: firstDateOfMonth, diffDayFromStart: diffDay)
                        )
                    }
                } else {
                    if dayOfMonth <= numberOfDaysInMonth {
                        /* If first day of week in month in range*/
                        calendarDays.append(
                            self.buildCalendarDayInCurrentMonth(dayOfMonth)
                        )
                        dayOfMonth += 1
                    } else {
                        let diffDay = weekDay - lastDayOfWeekInMonth
                        calendarDays.append(
                            self.buildCalendarDayInPreviousMonth(startDateOfMonth: lastDateOfMonth, diffDayFromStart: diffDay)
                        )
                    }
                }
            }
            
            calendarWeeks.append(
                CalendarWeek(calendarDays: calendarDays)
            )
        }
        
        return calendarWeeks
    }
    
    private func buildCalendarDayInCurrentMonth(_ dayOfMonth: Int) -> CalendarDay {
        
        let date = Date.from(year: self.calendarMonth.year, month: self.calendarMonth.month, day: dayOfMonth, calendar: calendar)
        
        return CalendarDay(
            date: date,
            hasEvents: hasEvents(from: date)
        )
    }
    
    private func buildCalendarDayInPreviousMonth(startDateOfMonth: Date, diffDayFromStart: Int) -> CalendarDay {
        
        guard let dateOfPreviousMonth = startDateOfMonth.addingComponentsOfDate(day: diffDayFromStart) else {
            return CalendarDay()
        }
        
        return CalendarDay(
            date: dateOfPreviousMonth,
            isCurrentMonth: false
        )
    }
    
    private func buildCalendarDayInNextMonth(endDateOfMonth: Date, diffDayFromEnd: Int) -> CalendarDay {
        guard let dateOfNextMonth = endDateOfMonth.addingComponentsOfDate(day: diffDayFromEnd) else {
            return CalendarDay()
        }
        
        return CalendarDay(
            date: dateOfNextMonth,
            isCurrentMonth: false
        )
    }
    
    private func hasEvents(from date: Date?) -> Bool {
        calendarMonth.events.contains(where: { $0.eventDate == date })
    }
}

        
