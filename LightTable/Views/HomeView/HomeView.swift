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
    @Query(sort: \Period.period, order: .forward) private var periods: [Period]
    
    private let userDefaults = UserDefaults.standard
    
    private let startDay = TimeUtils.dateFormatter.date(from: "2026-3-2")!
    @AppStorage("termTotalWeeks") private var totalWeeks = 25
    @State private var currentWeek: Int? = TimeUtils.getCurrentWeeFromSpecificDay(from: TimeUtils.dateFormatter.date(from: "2026-3-2")!, to: Date())
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(1...totalWeeks, id: \.self) { weeks in
                    TablePage(week: weeks, courses: courses, periods: periods, startDay: startDay)
                        .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $currentWeek)
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
