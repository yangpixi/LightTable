//
//  Table.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
// 从网页上提取课表时中间DTO类

import Foundation

struct Table: Decodable {
    let term: String
    let courses: [Course]
    
    init(term: String, courses: [Course]) {
        self.term = term
        self.courses = courses
    }
}
