//
//  CalendarHorizontalPaggingViewModel.swift
//  Demo
//
//  Created by Wisanu Paunglumjeak on 12/1/2568 BE.
//

import Foundation

class CalendarHorizontalPaggingViewModel: ObservableObject {
    @Published var calendar: Calendar
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var currentMonth: Date
    
    init() {
        let calendar = Calendar.init(identifier: .gregorian)
        let nowComponents = calendar.dateComponents([.year, .month], from: Date())
        
        self.calendar = calendar
        self.startDate = Date.from(year: nowComponents.year!, month: 1, day: 1, calendar: .init(identifier: .gregorian))!
        self.endDate = Date.from(year: nowComponents.year! + 100, month: 12, day: 30, calendar: .init(identifier: .gregorian))!
        self.currentMonth = Date.from(year: nowComponents.year!, month: nowComponents.month!, day: 1, calendar: .init(identifier: .gregorian))!
    }
    
    func isDateGreaterThanOrEqualStartDate(_ date: Date) -> Bool {
        date >= startDate
    }
    
    func isDateLessThanOrEqualEndDate(_ date: Date) -> Bool {
        date <= endDate.endOfMonth
    }
}
