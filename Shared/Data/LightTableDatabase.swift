//
//  LightTableDatabase.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import Foundation
import SwiftData

@MainActor
class LightTableDatabase {
    
    private static let initializingFlag = "isInitialized"
    
    static let sharedContainer: ModelContainer = {
        let groupName = "group.com.yangpixi.LightTable"
        let schema = Schema([
            Period.self,
            Course.self,
            SchoolDetail.self,
            Table.self
        ])
        
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, groupContainer: .identifier(groupName))
        
        do {
            let container = try ModelContainer(for: schema, configurations: configuration)
            checkAndDoInitialization(container: container)
            return container
        } catch {
            fatalError("无法初始化 SwiftData 容器: \(error)")
        }
    }()
    
    private static func checkAndDoInitialization(container: ModelContainer) {
        let userDefaults = UserDefaults(suiteName: "group.com.yangpixi.LightTable")
        
        // 如果存在这个flag，则代表数据库已经初始化了
        if userDefaults?.bool(forKey: initializingFlag) ?? false {
            return
        }
        
        let context = ModelContext(container)
        
        let defaultPeriods = [
            Period(period: 1, startTime: "08:00", endTime: "08:45"),
            Period(period: 2, startTime: "08:55", endTime: "09:40"),
            Period(period: 3, startTime: "10:00", endTime: "10:45"),
            Period(period: 4, startTime: "10:55", endTime: "11:40"),
            Period(period: 5, startTime: "14:00", endTime: "14:45"),
            Period(period: 6, startTime: "14:55", endTime: "15:40"),
            Period(period: 7, startTime: "16:00", endTime: "16:45"),
            Period(period: 8, startTime: "16:55", endTime: "17:40"),
            Period(period: 9, startTime: "19:00", endTime: "19:45"),
            Period(period: 10, startTime: "19:55", endTime: "20:40")
        ]
        
        defaultPeriods.forEach { period in
            context.insert(period)
        }
        
        let defaultSchool = ["Csu":"中南大学"]
        let defaultSchoolPortal = ["Csu":"http://csujwc.its.csu.edu.cn/sso.jsp"]
        
        defaultSchool.forEach { school in
            guard let script = ScriptUtils.loadExtractScript(for: school.key) else {
                print("\(school)脚本初始化失败")
                return
            }
            context.insert(SchoolDetail(shortName: school.key, name: school.value, extractScript: script, portalUrl: defaultSchoolPortal[school.key]!))
        }
        
        do {
            try context.save()
            userDefaults?.set(true, forKey: initializingFlag)
            print("默认数据初始化成功！")
        } catch {
            print("初始数据保存失败: \(error)")
        }
    }
}
