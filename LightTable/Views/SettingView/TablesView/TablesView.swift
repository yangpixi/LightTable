//
//  TableView.swift
//  LightTable
//
//  Created by 空白 on 2026/7/7.
//

import SwiftUI
import SwiftData

struct TablesView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Query private var tables: [Table]
    
    private var viewModel = TablesViewModel()
    
    var body: some View {
        List {
            ForEach(tables, id: \.self) { table in
                Text(table.term)
                    .swipeActions(edge: .trailing) { 
                        Button(role: .destructive) { 
                            viewModel.deleteTable(table)
                        }
                    }
            }
        }
        .onAppear {
            viewModel.injectContext(modelContext)
        }
        .toolbar {
            ToolbarItem { 
                Menu {
                    NavigationLink("导入新课表", value: SettingViewRouter.importTable)
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}
