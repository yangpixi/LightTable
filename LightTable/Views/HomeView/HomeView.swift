//
//  HomeView.swift
//  LightTable
//
//  Created by 空白 on 2026/6/14.
//

import SwiftUI
import System
import SwiftData

struct HomeView: View {
    
    @Query private var courses: [Course]
    @Query private var periods: [Period]
    private var weekdays = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            let startDay = TimeUtils.dateFormatter.date(from: "2026-3-2")!
            let week = TimeUtils.getCurrentWeeFromSpecificDay(from: startDay, to: Date())
            Text("第 \(week) 周")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 10)
                .bold()
            let periodHeight = CGFloat(50)
            let padding = CGFloat(10)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
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
                                    Text(weekday)
                                        .offset(y: -30)
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationDestination(for: HomeRouter.self, destination: { item in
            switch item {
            case .importTable: // 导入课表的路由
                TableImportView()
            case .tableSettings: 
                TableSettingsView()
            }
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    NavigationLink("导入新课表", value: HomeRouter.importTable)
                    NavigationLink("课表设置", value: HomeRouter.tableSettings)
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
