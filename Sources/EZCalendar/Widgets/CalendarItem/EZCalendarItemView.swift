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
    private var gridLineColor: Color? = nil
    
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
        
        let gridView = LazyVGrid(columns: columns, spacing: 1) {
//            let _ = print("🟢 item count | \(days.count)")
            ForEach(days, id: \.self) { calendarDay in
//                let _ = print("day | \(calendarDay.date!)")
                dayItemViewContent(calendarDay)
            }
        }
        
        if self.gridLineColor == nil {
            gridView
        } else {
            gridView
                .padding(1)
                .background(self.gridLineColor)
        }
        
        
//        VStack(spacing: 0) {
//            ForEach(viewModel.calendarWeeks, id: \.self) { calendarWeek in
//                HStack(spacing: 0) {
//                    ForEach(calendarWeek.calendarDays, id: \.self) { calendarDay in
//                        dayItemViewContent(calendarDay)
//                    }
//                }
//            }
//        }
    }
    
    func gridLineColor(_ color: Color?) -> Self {
        guard let color else {
            return self
        }
        
        var newView = self
        newView.gridLineColor = color
        return newView
    }
}
