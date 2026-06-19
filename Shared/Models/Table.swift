//
//  Untitled.swift
//  LightTable
//
//  Created by 空白 on 2026/6/17.
//

import Foundation
import SwiftData

@Model
class Table: Identifiable, Hashable {
    @Attribute(.unique) var id = UUID()
    
    var term: String
    var totalWeeks: Int
    var startDay: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Course.table) 
    var courses: [Course] = []
    
    init(term: String, totalWeeks: Int, startDay: Date) {
        self.term = term
        self.totalWeeks = totalWeeks
        self.startDay = startDay
    }
    
}
