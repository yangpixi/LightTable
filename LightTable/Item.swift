//
//  Item.swift
//  LightTable
//
//  Created by 空白 on 2026/6/14.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
