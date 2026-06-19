//
//  HomeViewModle.swift
//  LightTable
//
//  Created by 空白 on 2026/6/17.
//

import SwiftUI
import SwiftData

@Observable
class HomeViewModel {
    
    var currentTable: Table? {
        didSet {
            guard let startDay = currentTable?.startDay else {
                return
            }
            
            currentWeek = TimeUtils.getCurrentWeekFromSpecificDay(from: startDay)
        }
    }
    
    var currentWeek: Int? = 1
    var courses: [Course]?
    
    func loadData(modelContext: ModelContext) {
        if let tableIdStr = UserDefaults(suiteName: "group.com.yangpixi.LightTable")?.string(forKey: "selected_table") {
            
            guard let tableId = UUID(uuidString: tableIdStr) else {
                print("UUID转换出错")
                return
            }
            
            let tablePredicate = #Predicate<Table> { table in
                table.id == tableId
            }
            let tableModelDescriptor = FetchDescriptor(predicate: tablePredicate)
            
            do {
                let tableRes = try modelContext.fetch(tableModelDescriptor)
                
                guard let firstTable = tableRes.first, tableRes.count <= 1 else {
                    print("查询数据异常")
                    return
                }
                
                currentTable = firstTable
                courses = firstTable.courses
                
            } catch {
                print("加载课表发生异常: \(error)")
                return
            }
            
        }
    }
}
