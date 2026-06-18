//
//  Period.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import SwiftUI
import SwiftData

@Model
class Period: Identifiable {
    var id = UUID()
    var period: Int
    
    var startTimeMinutes: Int
    var endTimeMinutes: Int
    
    init(period: Int, startTime: String, endTime: String) {
        self.period = period
        self.startTimeMinutes = Period.parseStringToMinutes(startTime)
        self.endTimeMinutes = Period.parseStringToMinutes(endTime)
    }
    
    var startTimeComponents: DateComponents {
        DateComponents(hour: startTimeMinutes / 60, minute: startTimeMinutes % 60)
    }
    
    var endTimeComponents: DateComponents {
        DateComponents(hour: endTimeMinutes / 60, minute: endTimeMinutes % 60)
    }
    
    var startTime: String {
        String(format: "%02d:%02d", startTimeMinutes / 60, startTimeMinutes % 60)
    }
    
    var endTime: String {
        String(format: "%02d:%02d", endTimeMinutes / 60, endTimeMinutes % 60)
    }
    
    // MARK: - 辅助解析函数
    private static func parseStringToMinutes(_ timeString: String) -> Int {
        let parts = timeString.split(separator: ":").compactMap { Int($0) }
        guard parts.count >= 2 else { return 0 }
        let hour = parts[0]
        let minute = parts[1]
        return (hour * 60) + minute
    }
}
