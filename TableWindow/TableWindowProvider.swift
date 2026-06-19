//
//  TableWindowProvider.swift
//  LightTable
//
//  Created by 空白 on 2026/6/18.
//

import WidgetKit
import SwiftData

struct TableWindowProvider: @MainActor TimelineProvider {
    
    @MainActor
    private func fetchLatestCourse() -> ResDTO? {
        let modelContext = ModelContext(LightTableDatabase.sharedContainer)
        let userDefaults = UserDefaults(suiteName: "group.com.yangpixi.LightTable")
        
        guard let userDefaults = userDefaults else {
            print("UserDefaults获取失败")
            return nil
        }
        
        if let currentTableStr = userDefaults.string(forKey: "selected_table") {
            let tableUuid = UUID(uuidString: currentTableStr)
            
            guard let tableUuid = tableUuid else {
                print("uuid格式化失败")
                return nil
            }
            
            let tablePredicate = #Predicate<Table> { table in
                table.id == tableUuid
            }
            let tableDescriptor = FetchDescriptor(predicate: tablePredicate)
            
            let periodDesciptor = FetchDescriptor<Period>(sortBy: [.init(\.period)])
            
            do {
                let tableRes = try modelContext.fetch(tableDescriptor)
                let periodRes = try modelContext.fetch(periodDesciptor)
                
                
                
                guard let firstTable = tableRes.first else {
                    print("获取table失败")
                    return nil
                }
                
                let currentWeek = TimeUtils.getCurrentWeekFromSpecificDay(from: firstTable.startDay)
                let currentWeekday = TimeUtils.getCurrentWeekday()
                let todayCourses = CourseUtils.coursesFor(weekday: currentWeekday, week: currentWeek, in: firstTable.courses)
                let currentPeriod = CourseUtils.getCurrentPeriod(in: periodRes)
                
                // MARK: filter the current and next courses
                var selectedCourses: [Course] = [] 
                var periodStr: [UUID:String] = [:]
                var usedPeriods: Set<Int> = []
                
                
                if let currentPeriod = currentPeriod {
                    for period in 1...currentPeriod.period {
                        usedPeriods.insert(period)
                    }
                }

                for periodItem in periodRes {
                    if selectedCourses.count == 2 { 
                        break 
                    }
                    
                    if usedPeriods.contains(periodItem.period) { 
                        continue 
                    }
                    
                    for course in todayCourses {
                        if course.period.contains(periodItem.period) {                            
                            selectedCourses.append(course)
                            let strStartTime = periodRes.first {$0.period == course.period.first}?.startTime ?? "00"
                            let strEndTime = periodRes.first {$0.period == course.period.last}?.endTime ?? "00"
                            periodStr.updateValue("\(strStartTime)-\(strEndTime)", forKey: course.id) 
                            usedPeriods.formUnion(course.period)
                            break
                        }
                    }
                }
                
                return ResDTO(courses: selectedCourses, currentWeek: currentWeek, periodStr: periodStr)
            } catch {
                print("查询课程异常: \(error)")
                return nil
            }
        }
        return nil
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (TableEntry) -> Void) {
        let mockTable = Table(term: "2025-2026-2", totalWeeks: 20, startDay: .now)
        let mockCourse = Course(name: "高等数学", location: "A座101", teacher: "昊王", weekInterval: [1, 2], weekday: 1, period: [1, 2], table: mockTable)
        let entry = TableEntry(date: Date(), courses: [mockCourse], currentWeek: 1, periodStr: [mockCourse.id:"08:00-9:40"])
        completion(entry)
    }
    
    @MainActor
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<TableEntry>) -> Void) {
        let dto = fetchLatestCourse() // 包括当前正在(即将)上的课以及下一节课
        
        let entry = TableEntry(date: .now, courses: dto?.courses, currentWeek: dto?.currentWeek, periodStr: dto?.periodStr)
        
        let nextUpdateAt = Calendar.current.date(byAdding: .minute, value: 30, to: .now)
        
        completion(Timeline(entries: [entry], policy: .after(nextUpdateAt!)))
    }
    
    func placeholder(in context: Context) -> TableEntry {
        TableEntry(date: Date(), courses: [], currentWeek: 1, periodStr: [:])
    }
    
}
