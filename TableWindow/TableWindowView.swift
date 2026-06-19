//
//  TableWindowView.swift
//  LightTable
//
//  Created by 空白 on 2026/6/18.
//

import SwiftUI
import WidgetKit

struct TableWindowView: View {
    
    let entry: TableEntry
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        return formatter
    }()
    
    var dateToDisplay: String {
        dateFormatter.string(from: entry.date)
    }
    
    var body: some View {
        VStack(spacing: 1) {
            if let courses = entry.courses, let firstCourse = courses.first, let table = firstCourse.table, let period = entry.periodStr?[firstCourse.id] {
                
                Title(term: table.term, date: dateToDisplay, week: entry.currentWeek ?? 0)
                
                Text("Soon:")
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                CourseBean(course: firstCourse, period: period)
                
                if courses.count == 2, let nextCourse = courses.last {
                    Divider()
                    
                    Text("Next:")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Group {
                        Text(nextCourse.name)
                        Text(nextCourse.location)
                    }
                    .font(.footnote)
                }
            } else {
                Text("暂无课程")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .containerBackground(.clear, for: .widget)
    }
}

