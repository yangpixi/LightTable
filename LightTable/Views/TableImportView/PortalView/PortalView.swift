//
//  PortalView.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import SwiftUI

struct PortalView: View {
    
    private var url: String
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        WebView(url: URL(string: url)!) { result in
            print(result)
        }
        .navigationTitle("导入新课表")
        .navigationBarTitleDisplayMode(.inline) // 缩小顶部标题
        .toolbar(.hidden, for: .tabBar) // 隐藏tabBar
        .overlay(alignment: .bottomTrailing) {
            Button {
                print("importing new table")
            } label: {
                Image(systemName: "plus")
                    .font(.title2.weight(.semibold))
                    .padding(16)
            }
            .glassEffect()
            .padding(.trailing, 20)
            .padding(.bottom, 20)
        }
    }
}
