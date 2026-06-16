//
//  Untitled.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import Foundation
import SwiftData

@Model
class SchoolDetail {
    @Attribute(.unique) var id = UUID()
    var name: String // 学校名称
    var extractScript: String // 课表提取脚本
    var portalUrl: String // 门户网站
    
    init(name: String, extractScript: String, portalUrl: String) {
        self.name = name
        self.extractScript = extractScript
        self.portalUrl = portalUrl
    }
}
