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
            
            currentWeek = TimeUtils.getCurrentWeeFromSpecificDay(from: startDay)
        }
    }
    
    var currentWeek: Int? = 1
    
    func loadData(modelContext: ModelContext) {
        if let tableIdStr = UserDefaults.standard.string(forKey: "selected_table") {
            
            guard let tableId = UUID(uuidString: tableIdStr) else {
                print("UUID转换出错")
                return
            }
            
            let predicate = #Predicate<Table> { table in
                table.id == tableId
            }
            
            let modelDescriptor = FetchDescriptor(predicate: predicate)
            
            do {
                let res = try modelContext.fetch(modelDescriptor)
                
                guard let firstTable = res.first, res.count <= 1 else {
                    print("查询数据异常")
                    return
                }
                
                currentTable = firstTable
                
            } catch {
                print("加载课表发生异常: \(error)")
                return
            }
        }
    }
}
