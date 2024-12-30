//
//  EZCalendarWeekdayHeaderView.swift
//  EZCalendar
//
//  Created by Wisanu Paunglumjeak on 25/12/2567 BE.
//

import SwiftUI

public struct EZCalendarWeekdayHeaderView<WeekdayItemView>: View where WeekdayItemView: View {
    
    var weekDayTitles: [String] = []
    var weekdayItemViewContent: (String) -> WeekdayItemView
    
    init(
        weekDayTitles: [String]? = nil,
        @ViewBuilder weekdayItemViewContent: @escaping (String) -> WeekdayItemView
    ) {
        if let weekDayTitles {
            self.weekDayTitles = weekDayTitles
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale.current
            self.weekDayTitles = formatter.shortWeekdaySymbols
        }
        self.weekdayItemViewContent = weekdayItemViewContent
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(weekDayTitles, id: \.self) { title in
                weekdayItemViewContent(title)
            }
        }
    }
}

#Preview {
    GeometryReader { proxy in
        ScrollView {
            VStack(spacing: 0) {
                EZCalendarWeekdayHeaderView { title in
                    Text(title)
                        .foregroundStyle(Color.red)
                        .bold()
                        .frame(
                            width: proxy.size.width / 7,
                            height: 24
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
