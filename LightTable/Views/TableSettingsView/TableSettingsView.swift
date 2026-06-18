//
//  TableSettingsView.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import SwiftUI
import SwiftData

struct TableSettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = TableSettingsViewModel()
    @Query private var tables: [Table]
    @Query(sort: \Period.period, order: .forward) private var periods: [Period]
    
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        List {
            Section {
                Picker("当前课表", selection: $viewModel.selectedTable) {
                    Text("请选择课表").tag(Table?.none)
                    
                    ForEach(tables) { table in
                        Text(table.term).tag(Table?.some(table))
                    }
                }
                if viewModel.selectedTable != nil {
                    NavigationLink("时间设置", value: TableSettingsRouter.timeSetting)    
                }
            }
            
            Section(header: Text("参数设置")) {
                if let id = viewModel.selectedTable?.id,
                   let table = tables.first(where: { $0.id == id }) {
                    let bindingTable = Bindable(table)
                    LabeledContent { 
                        TextField("请输入课表名称", text: bindingTable.term)
                            .multilineTextAlignment(.trailing)
                            .focused($isInputFocused)
                            .onChange(of: isInputFocused) { _, isFocused in
                                if !isFocused {
                                    if table.term.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                        table.term = "未命名课表"
                                    }
                                }
                            }
                    } label: { 
                        Text("课表名称")
                    }
                    Stepper("学期周数: \(table.totalWeeks)", value: bindingTable.totalWeeks)
                    DatePicker(
                        "开始时间",
                        selection: bindingTable.startDay,
                        displayedComponents: [.date]
                    )
                } else {
                    Text("请先选择一个课表以进行设置")
                }
            }
            
        }
        .scrollDismissesKeyboard(.interactively)
        .onAppear {
            viewModel.initData(modelContext: modelContext)
        }
        .navigationTitle("课表设置")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: TableSettingsRouter.self, destination: { router in
            switch router {
            case .timeSetting:
                TimeSettingView()
            }
        })
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}

#Preview {
    TableSettingsView()
}
