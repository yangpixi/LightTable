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
    
    static func saveImportedCourses(_ rawData: String) {
        
        let modelContext = ModelContext(LightTableDatabase.sharedContainer)
        
        if let jsonData = rawData.data(using: .utf8) {
            let decoder = JSONDecoder()
            
            do {
                let dto = try decoder.decode(TableDTO.self, from: jsonData)
                dto.courses.forEach { course in
                    modelContext.insert(course)
                }
                print("导入课表成功! ")
            } catch {
                print("json解析失败: \(error)")
            }
        }
    }
}
