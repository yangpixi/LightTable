//
//  TableEntry.swift
//  LightTable
//
//  Created by 空白 on 2026/6/18.
//

import WidgetKit
import Foundation

struct TableEntry: TimelineEntry {
    let date: Date
    let courses: [Course]?
    let currentWeek: Int?
    let periodStr: [UUID:String]?
}


