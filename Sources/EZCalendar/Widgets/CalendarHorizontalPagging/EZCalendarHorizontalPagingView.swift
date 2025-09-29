//
//  EZCalendarHorizontalPagingView.swift
//  MyCalendarComponent
//
//  Created by Wisanu Paunglumjeak on 16/12/2567 BE.
//

import SwiftUI

public struct EZCalendarHorizontalPagingView<WeekdayItemView, DayItemView>: View
where WeekdayItemView: View, DayItemView: View {
    
    @ObservedObject public var viewModel: EZCalendarHorizontalPagingViewModel
    public var weekdayItemViewContent: (String) -> WeekdayItemView
    public var dayItemViewContent: (CalendarDay) -> DayItemView
    
    public init(
        viewModel: EZCalendarHorizontalPagingViewModel,
        @ViewBuilder weekdayItemViewContent: @escaping (String) -> WeekdayItemView,
        @ViewBuilder dayItemViewContent: @escaping (CalendarDay) -> DayItemView
    ) {
        self.viewModel = viewModel
        self.weekdayItemViewContent = weekdayItemViewContent
        self.dayItemViewContent = dayItemViewContent
    }
    
    var gridLineColor: Color? = nil
    public func gridLineColor(_ color: Color?) -> Self {
        guard let color else {
            return self
        }
        
        var newView = self
        newView.gridLineColor = color
        return newView
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
                        ForEach(viewModel.calendarMonths, id: \.hashString) { calendarMonth in
                            VStack(spacing: 0) {
                                
                                if isWeekdayScrollable {
                                    EZCalendarWeekdayHeaderView(weekdayItemViewContent: weekdayItemViewContent)
                                }
                                
                                EZCalendarItemView(
                                    calendarMonth,
                                    calendar: viewModel.calendar,
                                    dayItemViewContent: dayItemViewContent
                                )
                                .gridLineColor(self.gridLineColor)
                            }
                            .id(calendarMonth.uuid)
                        }
                    }
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $viewModel.activeCalendarMonthUUID)
            .scrollIndicators(.never)
        }
        .onChange(of: viewModel.activeCalendarMonthUUID) { _, activeCalendarMonthUUID in
            DispatchQueue.main.async {
                guard let currentMonth = viewModel.getCurrentMonth(fromUUID: activeCalendarMonthUUID) else {
                    return
                }
                
                self.viewModel.currentMonth = currentMonth
            }
        }
        .onChange(of: viewModel.currentMonth) { _, newValue in
            guard let currentMonth = viewModel.getCurrentMonth(fromUUID: viewModel.activeCalendarMonthUUID) else {
                return
            }
            
            guard currentMonth != newValue, let calendarMonth = viewModel.getCalendarMonth(fromDate: newValue) else {
                return
            }
            
            withAnimation {
                viewModel.activeCalendarMonthUUID = calendarMonth.uuid
            }
        }
        .onAppear{
            viewModel.activeCalendarMonthUUID = viewModel.getCalendarMonth(fromDate: viewModel.currentMonth)?.uuid
        }
    }
}
