//
//  DayLocalFormatter.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

class DayLocalFormatter: IDayLocalFormatter {
    
    // MARK: Properties
    
    private let formatter = DateFormatter()
    private var calendar: Calendar
    
    // MARK: Lifecycle
    
    init(locale: Locale, calendar: Calendar) {
        self.calendar = calendar
        self.calendar.locale = locale
        formatter.locale = locale
        formatter.calendar = calendar
    }
    
    // MARK: IDayFormatter
    
    func configure(timezone: GMTTimeZone) {
        guard let timezone = TimeZone(secondsFromGMT: timezone) else {
            return
        }
        
        formatter.timeZone = timezone
        calendar.timeZone = timezone
    }
    
    func relativeDay(from date: Date) -> String {
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        }
    }
    
    func formattedDay(from date: Date) -> String {
        formatter.dateFormat = "DD MMMM"
        return formatter.string(from: date)
    }
    
    func formattedTime(from date: Date) -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
