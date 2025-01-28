//
//  EZCalendarHorizontalPagingView.swift
//  MyCalendarComponent
//
//  Created by Wisanu Paunglumjeak on 16/12/2567 BE.
//

import SwiftUI

public struct EZCalendarHorizontalPagingView<WeekdayItemView, DayItemView>: View
where WeekdayItemView: View, DayItemView: View {
    
    @Binding var currentMonth: Date
    @StateObject var viewModel: EZCalendarHorizontalPagingViewModel
    var weekdayItemViewContent: (String) -> WeekdayItemView
    var dayItemViewContent: (CalendarDay) -> DayItemView
    
    @State var activeCalendarMonthUUID: String? = nil
    
    public init(
        currentMonth: Binding<Date>,
        viewModel: StateObject<EZCalendarHorizontalPagingViewModel>,
        weekdayItemViewContent: @escaping (String) -> WeekdayItemView,
        dayItemViewContent: @escaping (CalendarDay) -> DayItemView
    ) {
        self._currentMonth = currentMonth
        self._viewModel = viewModel
        self.weekdayItemViewContent = weekdayItemViewContent
        self.dayItemViewContent = dayItemViewContent
        self.activeCalendarMonthUUID = activeCalendarMonthUUID
    }

    var isWeekdayScrollable: Bool = false
    
    public func weekdayScrollable(_ isWeekdayScrollable: Bool) -> Self {
        var view = self
        view.isWeekdayScrollable = isWeekdayScrollable
        return view
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            
            if !isWeekdayScrollable {
                EZCalendarWeekdayHeaderView(weekdayItemViewContent: weekdayItemViewContent)
            }
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 0) {
                    Group {
                        ForEach(viewModel.calendarMonths, id: \.self) { calendarMonth in
                            VStack(spacing: 0) {
                                
                                if isWeekdayScrollable {
                                    EZCalendarWeekdayHeaderView(weekdayItemViewContent: weekdayItemViewContent)
                                }
                                
                                EZCalendarItemView(
                                    calendarMonth,
                                    calendar: viewModel.calendar,
                                    dayItemViewContent: dayItemViewContent
                                )
                                .gridLineColor(.red)
                            }
                            .id(calendarMonth.uuid)
                        }
                    }
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeCalendarMonthUUID)
            .scrollIndicators(.never)
        }
        .onChange(of: activeCalendarMonthUUID) { _, activeCalendarMonthUUID in
            guard let currentMonth = viewModel.getCurrentMonth(fromUUID: activeCalendarMonthUUID) else {
                return
            }
            
            self.currentMonth = currentMonth
        }
        .onChange(of: currentMonth) { _, newValue in
            guard let currentMonth = viewModel.getCurrentMonth(fromUUID: activeCalendarMonthUUID) else {
                return
            }
            
            guard currentMonth != newValue, let calendarMonth = viewModel.getCalendarMonth(fromDate: newValue) else {
                return
            }
            
            withAnimation {
                activeCalendarMonthUUID = calendarMonth.uuid
            }
        }
        .onAppear{
            activeCalendarMonthUUID = viewModel.getCalendarMonth(fromDate: currentMonth)?.uuid
        }
    }
}
