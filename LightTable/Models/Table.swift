//
//  Untitled.swift
//  LightTable
//
//  Created by 空白 on 2026/6/17.
//

import Foundation
import SwiftData

@Model
class Table {
    @Attribute(.unique) var id = UUID()
    var term: String
    var totalWeeks: Int
    var startDay: Date
    
    init(term: String, totalWeeks: Int, startDay: Date) {
        self.term = term
        self.totalWeeks = totalWeeks
        self.startDay = startDay
    }
}
