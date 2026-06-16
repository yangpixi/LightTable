//
//  TimeUtils.swift
//  LightTable
//
//  Created by 空白 on 2026/6/14.
//

import Foundation

struct TimeUtils {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    static let calendar: Calendar = {
        return Calendar.current
    }()
    
    // 获取当前月份
    static func getCurrentMonth() -> Int {
        return Calendar.current.component(.month, from: Date())
    }
    
    // 获取当前周数
    static func getCurrentWeeFromSpecificDay(from start: Date, to end: Date) -> Int {
        
        let startCalendar = calendar.startOfDay(for: start)
        let endCalendar = calendar.startOfDay(for: end)
        
        let gap = calendar.dateComponents([.weekOfYear], from: startCalendar, to: endCalendar).weekOfYear ?? 0
        
        return gap + 1
    }
    
    
    static func getDateOf(week targetWeek: Int, weekday: Int, since startDate: Date) -> Int {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        let startMidnight = calendar.startOfDay(for: startDate)
        
        let weeksToAdd = targetWeek - 1
        
        guard let dateInTargetWeek = calendar.date(byAdding: .weekOfYear, value: weeksToAdd, to: startMidnight) else {
            return 0
        }
        
        var matchingComponents = DateComponents()
        matchingComponents.weekday = weekday
        
        let finalDate = calendar.nextDate(after: calendar.date(byAdding: .day, value: -1, to: dateInTargetWeek)!,
                                          matching: matchingComponents,
                                          matchingPolicy: .nextTime)
        let finalDay = calendar.dateComponents([.day], from: finalDate!).day
        return finalDay ?? 0
    }
    
    static func date(from str: String) -> Date? {
        return dateFormatter.date(from: str)
    }
}
