//
//  Period.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import SwiftUI
import SwiftData

@Model
class Period: Identifiable {
    @Attribute(.unique) var id = UUID()
    
    var period: Int
    var startTime: String
    var endTime: String
    
    init(period: Int, startTime: String, endTime: String) {
        self.period = period
        self.startTime = startTime
        self.endTime = endTime
    }
}
