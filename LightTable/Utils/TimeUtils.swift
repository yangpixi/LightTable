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
    
    // 获取当前日期
    static func getCurrentDay() -> Int {
        return Calendar.current.component(.day, from: Date())
    }
    
    // 获取当前周数
    static func getCurrentWeeFromSpecificDay(from start: Date) -> Int {
        
        let startCalendar = calendar.startOfDay(for: start)
        let endCalendar = calendar.startOfDay(for: Date())
        
        let gap = calendar.dateComponents([.weekOfYear], from: startCalendar, to: endCalendar).weekOfYear ?? 0
        
        return gap + 1
    }
    
    // 获取特定周某天的日期
    static func getDateOf(week targetWeek: Int, weekday: Int, since startDate: Date) -> Int {
        guard targetWeek > 0, (1...7).contains(weekday) else {
            return 0
        }
        
        let startMidnight = calendar.startOfDay(for: startDate)
        let startWeekday = calendar.component(.weekday, from: startMidnight)
        
        let weekdayOffset = (weekday - startWeekday + 7) % 7
        let daysToAdd = (targetWeek - 1) * 7 + weekdayOffset
        
        guard let finalDate = calendar.date(byAdding: .day, value: daysToAdd, to: startMidnight) else {
            return 0
        }
        
        return calendar.component(.day, from: finalDate)
    }
    
    // 获取特定周的月份
    static func getMonthOf(week targetWeek: Int, since startDate: Date) -> Int {
        guard targetWeek > 0 else {
            return 0
        }
        
        let startMidnight = calendar.startOfDay(for: startDate)
        let daysToAdd = (targetWeek - 1) * 7
        
        guard let finalDate = calendar.date(byAdding: .day, value: daysToAdd, to: startMidnight) else {
            return 0
        }
        
        return calendar.component(.month, from: finalDate)
    }
    
    static func date(from str: String) -> Date? {
        return dateFormatter.date(from: str)
    }
}
