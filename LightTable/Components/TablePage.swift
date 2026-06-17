//
//  TablePage.swift
//  LightTable
//
//  Created by 空白 on 2026/6/17.
//

import SwiftUI

struct TablePage: View {
    
    private var week: Int
    private var courses: [Course]
    private var periods: [Period]
    private var startDay: Date
    
    init(week: Int, courses: [Course], periods: [Period], startDay: Date) {
        self.week = week
        self.courses = courses
        self.periods = periods
        self.startDay = startDay
    }
    
    private let periodHeight = CGFloat(50)
    private let padding = CGFloat(10)
    private var weekdays = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("第 \(week) 周")
                .offset(x: 17)
                .bold()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // 当前月份
                    Text("\(TimeUtils.getCurrentMonth())月")
                        .gridColumnAlignment(.trailing)
                        .bold()
                        .padding(.horizontal, 10)
                        .frame(minWidth: 40, maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 5) {
                        VStack(spacing: padding) {
                            // 节次
                            ForEach(periods, id: \.id) { period in
                                VStack {
                                    Text("\(period.period)")
                                        .font(.footnote)
                                    Text(period.startTime)
                                        .font(.footnote)
                                    Text(period.endTime)
                                        .font(.footnote)
                                }
                                .frame(width: 40,height: periodHeight)
                            }
                        }
                        
                        ForEach(Array(weekdays.enumerated()), id: \.offset) { index, weekday in
                            VStack(alignment: .leading) {
                                ZStack(alignment: .top) {
                                    VStack(alignment: .center) {
                                        Text(weekday)
                                        Text("\(TimeUtils.getDateOf(week: week, weekday: index == 6 ? 1 : index + 2, since: startDay))")
                                            .font(.footnote)
                                            .foregroundStyle(.gray)
                                    }
                                    .offset(y: -40)
                                    
                                    ForEach(CourseUtils.coursesFor(weekday: index == 6 ? 1 : index + 2, week: week, in: courses)) { course in
                                        TableCourse(name: course.name, location: course.location)
                                            .frame(width: 45, height: (periodHeight * CGFloat(course.period.count)) + (CGFloat(course.period.count) - 1) * padding)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(.black, lineWidth: 1)
                                            )
                                            .offset(y: CGFloat(course.period.first! - 1) * (periodHeight + padding))
                                    }
                                }
                            }
                            .frame(minWidth: 45, maxHeight: .infinity, alignment: .top)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .safeAreaPadding()
        }
    }
}
