//
//  TablesViewModel.swift
//  LightTable
//
//  Created by 空白 on 2026/7/7.
//

import Foundation
import SwiftData

class TablesViewModel {
    private var modelContext: ModelContext?
    
    func injectContext(_ modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }
    
    func deleteTable(_ table: Table) {
        guard let modelContext = modelContext else {
            print("modelContext未注入")
            return
        }
        
        modelContext.delete(table)
    }
}
