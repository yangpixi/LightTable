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
    private var onClickCourse: (Course) -> Void
    
    init(week: Int, courses: [Course], periods: [Period], startDay: Date, onClickCourse: @escaping (Course) -> Void) {
        self.week = week
        self.courses = courses
        self.periods = periods
        self.startDay = startDay
        self.onClickCourse = onClickCourse
    }
    
    private let periodHeight = CGFloat(50)
    private let padding = CGFloat(10)
    private var weekdays = ["日", "一", "二", "三", "四", "五", "六"]
    
    private var weekText: String {
        var weekText: String
        if week != currentWeek {
            weekText = "第 \(week) 周 (非本周)"
        } else {
            weekText = "第 \(week) 周"
        }
        return weekText
    }
    
    private var currentWeek: Int {
        TimeUtils.getCurrentWeekFromSpecificDay(from: startDay)
    }
    
    private var currentDay: Int {
        TimeUtils.getCurrentDay()
    }
    
    private func isToday(index: Int) -> Bool {
        if TimeUtils.getDateOf(week: week, weekday: index + 1, since: startDay) == currentDay && 
            week == currentWeek {
            return true
        }
        return false
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(weekText)
                .offset(x: 20)
                .bold()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // 当前月份
                    Text("\(TimeUtils.getMonthOf(week: week, since: startDay))月")
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
                                    Group {
                                        Text(period.startTime)
                                        Text(period.endTime)  
                                    }
                                    .foregroundStyle(.gray.opacity(0.9))
                                }
                                .font(.footnote.scaled(by: 0.9))
                                .frame(width: 40,height: periodHeight)
                            }
                        }
                        
                        // 横向渲染周日到周一的课表
                        ForEach(Array(weekdays.enumerated()), id: \.offset) { index, weekday in
                            VStack(alignment: .leading) {
                                ZStack(alignment: .top) {
                                    VStack(alignment: .center) {
                                        Text(weekday)
                                        Text("\(TimeUtils.getDateOf(week: week, weekday: index + 1, since: startDay))")
                                            .font(.footnote)
                                            .foregroundStyle(isToday(index: index) ? .black : .gray)
                                            .padding(.horizontal, 5)
                                            .background {
                                                if isToday(index: index) {
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .fill(Color.gray.opacity(0.2))
                                                }
                                            }
                                    }
                                    .offset(y: -40)
                                    
                                    // 每天的具体课程
                                    ForEach(CourseUtils.coursesFor(weekday: index + 1, week: week, in: courses)) { course in
                                        TableCourse(name: course.name, location: course.location)
                                            .frame(width: 45, height: (periodHeight * CGFloat(course.period.count)) + (CGFloat(course.period.count) - 1) * padding)
                                            .background {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .fill(Color.gray.opacity(0.2))
                                            }
                                            .offset(y: CGFloat(course.period.first! - 1) * (periodHeight + padding))
                                            .onTapGesture { 
                                                onClickCourse(course)
                                            }
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
