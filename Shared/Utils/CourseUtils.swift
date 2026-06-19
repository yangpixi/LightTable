//
//  CourseUtils.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import SwiftUI
import SwiftData

struct CourseUtils {
    
    static func coursesFor(weekday: Int, week: Int, in courses: [Course]) -> [Course] {
        courses
            .filter { course in
                course.weekday == weekday &&
                course.weekInterval.contains(week)
            }
            .sorted { ($0.period.first ?? 0) < ($1.period.first ?? 0) }
    }
    
    static func getCurrentPeriod(in periods: [Period]) -> Period? {
        for period in periods {
            let now = Date()
            let currentMin = Calendar.current.component(.hour, from: now) * 60 + Calendar.current.component(.minute, from: now)
            
            if currentMin < period.endTimeMinutes {
                return period
            }
        }
        return nil
    }
    
    @MainActor
    static func fetchScript(for school: String) -> String? {
        let modelContext = ModelContext(LightTableDatabase.sharedContainer)
        let predicate = #Predicate<SchoolDetail> { detail in
            detail.shortName == school
        }
        
        var fetchPredicate = FetchDescriptor<SchoolDetail>(predicate: predicate)
        fetchPredicate.fetchLimit = 1
        
        do {
            let res = try modelContext.fetch(fetchPredicate)
            return res.first?.extractScript
        } catch {
            print("查询失败: \(error)")
        }
        
        return nil
    }
    
    @MainActor
    static func saveImportedCourses(_ rawData: String) throws {
        
        let modelContext = ModelContext(LightTableDatabase.sharedContainer)
        modelContext.autosaveEnabled = false
        
        if let jsonData = rawData.data(using: .utf8) {
            let decoder = JSONDecoder()
            
            let dto = try decoder.decode(TableDTO.self, from: jsonData)
            let termStrs = dto.term.split(separator: "-")
            guard !termStrs.isEmpty && termStrs.count == 3 else {
                throw TermFormatError.formatInccorect(msg: "学期时间格式不正确！")
            }
            
            // parse the term time
            var startDay: String
            if termStrs.last == "1" {
                startDay = termStrs[0].appending("-9-1")
            } else if termStrs.last == "2" {
                startDay = termStrs[1].appending("-3-1")
            } else {
                throw TermFormatError.formatInccorect(msg: "学期时间格式不正确！")
            }
            
            let table = Table(term: dto.term, totalWeeks: 20, startDay: TimeUtils.dateFormatter.date(from: startDay)!) // all in defauls
            
            // insert data
            dto.courses.forEach { course in
                course.table = table
                modelContext.insert(course)
            }
            
            modelContext.insert(table)
            
            UserDefaults(suiteName: "group.com.yangpixi.LightTable")?.set(table.id.uuidString, forKey: "selected_table")
            
            try modelContext.save()
            print("导入课表成功! ")
            
        }
    }
}
