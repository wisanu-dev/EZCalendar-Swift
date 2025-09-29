//
//  File.swift
//  EZCalendar
//
//  Created by wisanu on 29/9/2568 BE.
//

import Foundation

public class EZCalendarHelper {
    
    public static func generateCalendarMonths(
        startDate: Date,
        endDate: Date,
        calendar: Calendar = .current,
        events: [CalendarEvent] = []
    ) -> [CalendarMonth] {
        var calendarMonths: [CalendarMonth] = []
        
        var currentFirstDateOfMonth = startDate.startOfMonth
        
        while currentFirstDateOfMonth <= endDate {
            
            let calendarComponents = calendar.dateComponents([.month, .year], from: currentFirstDateOfMonth)
            
            guard let year = calendarComponents.year, let month = calendarComponents.month else {
                break
            }
            
            calendarMonths.append(
                CalendarMonth(month: month, year: year)
            )
            
            guard let nextFirstDateOfMonth = currentFirstDateOfMonth.addingComponentsOfDate(month: 1) else {
                break
            }
            
            currentFirstDateOfMonth = nextFirstDateOfMonth
        }
        
        return calendarMonths
    }
    
    
}
