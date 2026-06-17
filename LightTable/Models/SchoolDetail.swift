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
    var shortName: String // 英文缩写
    var name: String // 学校名称
    var extractScript: String // 课表提取脚本
    var portalUrl: String // 门户网站
    
    init(shortName: String, name: String, extractScript: String, portalUrl: String) {
        self.shortName = shortName
        self.name = name
        self.extractScript = extractScript
        self.portalUrl = portalUrl
    }
}
