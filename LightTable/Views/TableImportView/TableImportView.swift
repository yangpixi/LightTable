//
//  TableImportView.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import SwiftUI
import SwiftData

struct TableImportView: View {
    
    @Query private var schoolDetails: [SchoolDetail]
    
    var body: some View {
        VStack {
            List(schoolDetails) { school in
                NavigationLink("\(school.name)", value: TableImportRouter.portalWebSite(shortName: school.shortName, url: school.portalUrl))
            }
        }
        .navigationTitle("选择课表来源学校")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: TableImportRouter.self) { router in
            switch router {
            case .portalWebSite(let shortName, let url):
                PortalView(shortName: shortName, url: url)
            }
        }
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}

