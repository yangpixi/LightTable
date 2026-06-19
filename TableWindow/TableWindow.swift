//
//  TableWindow.swift
//  LightTable
//
//  Created by 空白 on 2026/6/18.
//

import WidgetKit
import SwiftUI

@main
struct TableWindow: Widget {
    
    let kind = "TableWindow"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: TableWindowProvider()
        ) { entry in
            TableWindowView(entry: entry)
        }
        .configurationDisplayName("课表展示")
        .description("显示最近的课程")
        .supportedFamilies([
            .systemSmall
        ])
    }
}

#Preview(as: .systemSmall) {
    TableWindow()
} timeline: {
    let mockTable = Table(term: "2025-2026-2", totalWeeks: 20, startDay: .now)
    let mockCourse = Course(name: "高等数学", location: "A座101", teacher: "昊王", weekInterval: [1, 2], weekday: 1, period: [1, 2], table: mockTable)
    let mockCourse1 = Course(name: "离散数学", location: "A座101", teacher: "昊王", weekInterval: [1, 2], weekday: 1, period: [1, 2], table: mockTable)
    TableEntry(date: Date(), courses: [mockCourse, mockCourse1], currentWeek: 1, periodStr: [mockCourse.id:"08:00-9:40"])
}
