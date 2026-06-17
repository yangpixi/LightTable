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
    
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            if let currentTable = viewModel.currentTable {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(1...currentTable.totalWeeks, id: \.self) { weeks in
                            TablePage(week: weeks, courses: courses, periods: periods, startDay: currentTable.startDay)
                                .containerRelativeFrame(.horizontal)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: $viewModel.currentWeek)
            } else {
                Text("请先导入课表")
            }
        }
        .onAppear {
            viewModel.loadData(modelContext: modelContext)
        }
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
        .navigationDestination(for: HomeRouter.self, destination: { item in
            switch item {
            case .importTable: // 导入课表的路由
                TableImportView()
            case .tableSettings: 
                TableSettingsView()
            }
        })
        
        
    }
}

#Preview {
    HomeView()
}
