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
        VStack(spacing: 0) {
            ForEach(viewModel.calendarWeeks, id: \.self) { calendarWeek in
                HStack(spacing: 0) {
                    ForEach(calendarWeek.calendarDays, id: \.self) { calendarDay in
                        dayItemViewContent(calendarDay)
                    }
                }
            }
        }
    }
}
