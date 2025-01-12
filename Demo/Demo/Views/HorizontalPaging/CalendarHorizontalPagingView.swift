//
//  CalendarHorizontalPagingView.swift
//  Demo
//
//  Created by Wisanu Paunglumjeak on 12/1/2568 BE.
//

import SwiftUI
import EZCalendar

struct CalendarHorizontalPagingView: View {
    @StateObject var viewModel: CalendarHorizontalPaggingViewModel = .init()
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 24) {
                    
                    HStack {
                        Button("Previous") {
                            guard let date = viewModel.currentMonth.addingComponentsOfDate(month: -1),
                                  viewModel.isDateGreaterThanOrEqualStartDate(date) else {
                                return
                            }
                            viewModel.currentMonth = date
                        }
                        .disabled(
                            !viewModel.isDateGreaterThanOrEqualStartDate(
                                viewModel.currentMonth.addingComponentsOfDate(month: -1)!
                            )
                        )
                        .frame(width: 100, alignment: .leading)
                        
                        Spacer()
                        
                        Text(viewModel.currentMonth.toString(dateFormat: "MMMM yyyy"))
                        
                        Spacer()
                        
                        Button("Next") {
                            guard let date = viewModel.currentMonth.addingComponentsOfDate(month: 1),
                                  viewModel.isDateLessThanOrEqualEndDate(date) else {
                                return
                            }
                            viewModel.currentMonth = date
                        }
                        .disabled(
                            !viewModel.isDateLessThanOrEqualEndDate(
                                viewModel.currentMonth.addingComponentsOfDate(month: 1)!
                            )
                        )
                        .frame(width: 100, alignment: .trailing)
                    }
                    .bold()
                    .padding(16)
                    
                    EZCalendarHorizontalPagingView(
                        currentMonth: $viewModel.currentMonth,
                        viewModel: StateObject(
                            wrappedValue: EZCalendarHorizontalPagingViewModel(
                                viewModel.calendar,
                                startDate: viewModel.startDate,
                                endDate: viewModel.endDate
                            )
                        )
                    ) { weekdayTitle in
                        Text(weekdayTitle)
                            .foregroundStyle(Color.red)
                            .bold()
                            .frame(
                                width: proxy.size.width / 7,
                                height: 24
                            )
                    } dayItemViewContent: { calendarDay in
                        
                        Text(" \(calendarDay.date?.get(.day) ?? 0) ")
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
                    .weekdayScrollable(true)
                }
            }
        }
    }
}

#Preview {
    CalendarHorizontalPagingView()
}
