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
    
    init(
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

struct CalendarPagingView_Previews: PreviewProvider {
    
    class ViewModel: ObservableObject {
        @Published var calendar: Calendar
        @Published var startDate: Date
        @Published var endDate: Date
        @Published var currentMonth: Date
        
        init() {
            let calendar = Calendar.init(identifier: .gregorian)
            let nowComponents = calendar.dateComponents([.year, .month], from: Date())
            
            self.calendar = calendar
            self.startDate = Date.from(year: nowComponents.year!, month: 1, day: 1, calendar: .init(identifier: .gregorian))!
            self.endDate = Date.from(year: nowComponents.year!, month: 12, day: 30, calendar: .init(identifier: .gregorian))!
            self.currentMonth = Date.from(year: nowComponents.year!, month: nowComponents.month!, day: 1, calendar: .init(identifier: .gregorian))!
        }
        
        func isDateGreaterThanOrEqualStartDate(_ date: Date) -> Bool {
            date >= startDate
        }
        
        func isDateLessThanOrEqualEndDate(_ date: Date) -> Bool {
            date <= endDate.endOfMonth
        }
    }
    
    struct Container: View {
        
        @StateObject var viewModel: ViewModel = .init()
        
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
                        .weekdayScrollable(true)
                    }
                }
            }
        }
    }
    
    static var previews: some View {
        Container()
    }
}
