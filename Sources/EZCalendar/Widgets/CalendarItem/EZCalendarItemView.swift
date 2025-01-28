//
//  EZCalendarItemView.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import SwiftUI

public struct EZCalendarItemView<DayItemView>: View where DayItemView: View {
    
    @ObservedObject var viewModel: EZCalendarItemViewModel
    
    var dayItemViewContent: (CalendarDay) -> DayItemView
    
    public init(
        _ calendarMonth: CalendarMonth,
        calendar: Calendar,
        @ViewBuilder dayItemViewContent: @escaping (CalendarDay) -> DayItemView
    ) {
        self.viewModel = EZCalendarItemViewModel(
            calendarMonth: calendarMonth,
            calendar: calendar
        )
        self.dayItemViewContent = dayItemViewContent
    }
    
    public var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 1), count: 7)
        let days = viewModel.calendarWeeks.flatMap { $0.calendarDays }
        
        LazyVGrid(columns: columns, spacing: 1) {
            ForEach(days, id: \.self) { calendarDay in
                dayItemViewContent(calendarDay)
            }
        }
        .padding(1)
        .background(.red)
    }
    
}
