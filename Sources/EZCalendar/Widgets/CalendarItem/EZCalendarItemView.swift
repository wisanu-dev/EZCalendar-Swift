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
    
    init(
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

#Preview {
    GeometryReader { proxy in
        ScrollView {
            VStack(spacing: 24) {
                
                EZCalendarItemView(
                    CalendarMonth(month: 9, year: 2024),
                    calendar: .init(identifier: .gregorian)
                ) { calendarDay in
                    Text(" \(calendarDay.day ?? 0) ")
                        .foregroundStyle(
                            calendarDay.isCurrentMonth
                            ? Color.black
                            : Color.gray
                        )
                        .frame(
                            width: proxy.size.width / 7,
                            height: proxy.size.width / 7
                        )
                }
                
                EZCalendarItemView(
                    CalendarMonth(month: 10, year: 2024),
                    calendar: .init(identifier: .gregorian)
                ) { calendarDay in
                    Text(" \(calendarDay.day ?? 0) ")
                        .foregroundStyle(
                            calendarDay.isCurrentMonth
                            ? Color.black
                            : Color.gray
                        )
                        .frame(
                            width: proxy.size.width / 7,
                            height: proxy.size.width / 7
                        )
                }
                
                EZCalendarItemView(
                    CalendarMonth(month: 11, year: 2024),
                    calendar: .init(identifier: .gregorian)
                ) { calendarDay in
                    Text(" \(calendarDay.day ?? 0) ")
                        .foregroundStyle(
                            calendarDay.isCurrentMonth
                            ? Color.black
                            : Color.gray
                        )
                        .frame(
                            width: proxy.size.width / 7,
                            height: proxy.size.width / 7
                        )
                }
                
                EZCalendarItemView(
                    CalendarMonth(month: 12, year: 2024),
                    calendar: .init(identifier: .gregorian)
                ) { calendarDay in
                    Text(" \(calendarDay.day ?? 0) ")
                        .foregroundStyle(
                            calendarDay.isCurrentMonth
                            ? Color.black
                            : Color.gray
                        )
                        .frame(
                            width: proxy.size.width / 7,
                            height: proxy.size.width / 7
                        )
                }
            }
        }
    }
    .padding(16)
}
