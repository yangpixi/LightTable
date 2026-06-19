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
                .task {
                    LightTableDatabase.initializeDefaultDataIfNeeded()
                    await triggerNetworkPermissionPrompt()
                }
        }
        .modelContainer(LightTableDatabase.sharedContainer)
    }
    
    private func triggerNetworkPermissionPrompt() async {
        guard let url = URL(string: "https://captive.apple.com/hotspot-detect.html") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD" 
        request.timeoutInterval = 3 
        
        do {
            let _ = try await URLSession.shared.data(for: request)
        } catch {
            print("网络唤醒请求被拦截或失败: \(error.localizedDescription)")
        }
    }
}

