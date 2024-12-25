//
//  Date+.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 13/12/2567 BE.
//

import Foundation

extension Date {
    internal static func from(year: Int, month: Int, day: Int, calendar: Calendar = Calendar.current) -> Date?{
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        return calendar.date(from: dateComponents)
    }
    
    internal func addingComponentsOfDate(year: Int? = nil, month: Int? = nil, day: Int? = nil) -> Date? {
        
        if year != nil && month != nil && day != nil {
            return self
        }
        
        var dateCoponents = DateComponents()
        
        if let year {
            dateCoponents.year = year
        }
        
        if let month {
            dateCoponents.month = month
        }
        
        if let day {
            dateCoponents.day = day
        }

        return Calendar.current.date(byAdding: dateCoponents, to: self)
    }
    
    internal var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    internal var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    internal var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    internal var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    internal func toString(
        dateFormat: String
    ) -> String {
        let format = DateFormatter()
        format.dateFormat = dateFormat
        format.calendar = .init(identifier: .gregorian)
        return format.string(from: self)
    }
}
