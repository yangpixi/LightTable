//
//  Class.swift
//  LightTable
//
//  Created by 空白 on 2026/6/15.
//

import Foundation
import SwiftData

@Model
class Course: Identifiable, Decodable {
    @Attribute(.unique) var id = UUID()
    var name: String // 课程名称
    var location: String // 课程地点
    var teacher: String // 老师
    var weekInterval: [Int] // 课程开设周数
    var weekday: Int // 课程在一周中开设的星期(1 为周日)
    var period: [Int] // 课程在一天中开设的节次
    var table: Table? // 课程属于的课表
    
    init(name: String, location: String, teacher: String, weekInterval: [Int], weekday: Int, period: [Int], table: Table) {
        self.name = name
        self.location = location
        self.teacher = teacher
        self.weekInterval = weekInterval
        self.weekday = weekday
        self.period = period
        self.table = table
    }
    
    // MARK: - Decodable 手动实现
    enum CodingKeys: CodingKey {
        case id, name, location, teacher, weekInterval, weekday, period
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.location = try container.decode(String.self, forKey: .location)
        self.teacher = try container.decode(String.self, forKey: .teacher)
        self.weekInterval = try container.decode([Int].self, forKey: .weekInterval)
        self.weekday = try container.decode(Int.self, forKey: .weekday)
        self.period = try container.decode([Int].self, forKey: .period)
    }
}
