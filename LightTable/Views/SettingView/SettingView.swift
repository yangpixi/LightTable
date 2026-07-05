//
//  SettingView.swift
//  LightTable
//
//  Created by 空白 on 2026/6/14.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            NavigationLink("关于", value: SettingViewRouter.about)
        }
        .navigationDestination(for: SettingViewRouter.self, destination: { router in 
            switch router {
            case .about: 
                AboutView()
            }
        }
        )
    }
}

#Preview {
    SettingView()
}
