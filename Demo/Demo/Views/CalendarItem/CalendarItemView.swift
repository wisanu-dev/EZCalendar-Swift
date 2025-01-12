//
//  CalendarItemView.swift
//  Demo
//
//  Created by Wisanu Paunglumjeak on 12/1/2568 BE.
//

import SwiftUI
import EZCalendar

struct CalendarItemView: View {
    var body: some View {
        VStack {
            GeometryReader { proxy in
                ScrollView {
                    VStack(spacing: 0) {
                        
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
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 1)
                            .padding(16)
                        
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
                        
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 1)
                            .padding(16)
                        
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
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 1)
                            .padding(16)
                        
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
        }
    }
}

#Preview {
    CalendarItemView()
}
