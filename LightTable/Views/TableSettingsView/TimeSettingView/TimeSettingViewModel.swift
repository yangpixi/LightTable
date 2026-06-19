//
//  TimeSettingViewModel.swift
//  LightTable
//
//  Created by 空白 on 2026/6/19.
//

import SwiftData
import Foundation

@MainActor
class TimeSettingViewModel {
    
    private var modelContext: ModelContext?
    
    func injectContext(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func deleteItem(_ item: Period) {
        guard let modelContext = modelContext else {
            print("modelContext未注入")
            return
        }
        
        modelContext.delete(item)
    }
    
    func addItem() {
        guard let modelContext = modelContext else {
            print("modelContext未注入")
            return
        }
        
        let descriptor = FetchDescriptor<Period>(sortBy: [.init(\.period)])
        
        do {
            let periods = try modelContext.fetch(descriptor)
            
            guard periods.count > 0 else {
                print("period数量异常")
                return
            }
            
            let newPeriod = Period(period: periods.last!.period + 1, startTime: "00:00", endTime: "00:00")
            modelContext.insert(newPeriod)
        } catch {
            print("读取数据库出现异常: \(error)")
            return
        }
    }
}
