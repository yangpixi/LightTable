//
//  PortalView.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import SwiftUI

struct PortalView: View {
    
    private var shortName: String
    private var url: String
    
    private let webViewController = WebViewController()
    
    init(shortName: String, url: String) {
        self.shortName = shortName
        self.url = url
    }
    
    var body: some View {
        WebView(url: URL(string: url)!, webViewController: webViewController)
        .navigationTitle("导入新课表")
        .navigationBarTitleDisplayMode(.inline) // 缩小顶部标题
        .toolbar(.hidden, for: .tabBar) // 隐藏tabBar
        .overlay(alignment: .bottomTrailing) {
            Button {
                guard let scrip = CourseUtils.fetchScript(for: shortName) else {
                    print("获取脚本失败")
                    return
                }
                webViewController.runCustomJS(scrip) { result, error in
                    // 如果发生错误
                    if error != nil {
                        return
                    }
                    
                    // 将result转换为String类型
                    if let jsonString = result as? String {
                        CourseUtils.saveImportedCourses(jsonString)
                    }
                }
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
