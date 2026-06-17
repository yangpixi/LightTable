//
//  TableSettingsViewModel.swift
//  LightTable
//
//  Created by 空白 on 2026/6/17.
//

import SwiftUI
import SwiftData

@Observable
class TableSettingsViewModel {
    
    var selectedTable: Table? {
        didSet {
            UserDefaults.standard.set(selectedTable?.id.uuidString, forKey: "selected_table")
        }
    }
    
    func initData(modelContext: ModelContext) {
        
        if let currentTableIdStr = UserDefaults.standard.string(forKey: "selected_table") { // 如果UserDefaults里不为空
            
            guard let currentTableId = UUID(uuidString: currentTableIdStr) else {
                print("UUID转换出错")
                return
            }
            
            let predicate = #Predicate<Table> { table in
                table.id == currentTableId
            }
            
            let modelDescriptor = FetchDescriptor<Table>(predicate: predicate)
            
            do {
                let res = try modelContext.fetch(modelDescriptor)
                
                guard let firstTable = res.first else {
                    return
                }
                
                selectedTable = firstTable
                
            } catch {
                print("数据库查询失败")
                return
            }
        } else { // 如果UserDefaults里面为空
            
            let modelDescriptor = FetchDescriptor<Table>()
            do {
                let res = try modelContext.fetch(modelDescriptor)
                
                if res.count == 0 {
                    print("暂无导入的课表")
                    return
                }
                
                guard let firstTable = res.first else {
                    return
                }
                
                selectedTable = firstTable // 默认选择第一个课表
                UserDefaults.standard.set(firstTable.id.uuidString, forKey: "selected_table")
            } catch {
                print("数据库查询失败")
                return
            }
        }
    }
    
    
}
