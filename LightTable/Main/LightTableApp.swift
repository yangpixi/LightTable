//
//  LightTableApp.swift
//  LightTable
//
//  Created by 空白 on 2026/6/14.
//

import SwiftUI
import SwiftData

@main
struct LightTableApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(LightTableDatabase.sharedContainer)
    }
}

