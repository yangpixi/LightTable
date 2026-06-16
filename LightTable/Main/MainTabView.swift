//
//  TabView.swift
//  LightTable
//
//  Created by 空白 on 2026/6/14.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    
    @Query private var periods: [Period]
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
                    .navigationTitle("主页")
            }
            .tabItem{
                Label("首页", systemImage: "house")
            }
            
            NavigationStack {
                SettingView()
                    .navigationTitle("设置")
            }
            .tabItem{
                Label("设置", systemImage: "gear")
            }
        }
    }
}
