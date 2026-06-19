import SwiftUI
import SwiftData

struct TimeSettingView: View {
    @Query(sort: \Period.period, order: .forward) private var periods: [Period]
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    private let viewModel = TimeSettingViewModel()
    
    var body: some View {
        List {
            ForEach(Array(periods.enumerated()), id: \.offset) { index, period in
                PeriodSettingRow(period: period)
                    .swipeActions(edge: .trailing) {
                        if index == periods.count - 1 {
                            Button(role: .destructive) { 
                                viewModel.deleteItem(period)
                            }
                        }
                    }
            }
        }
        .onAppear {
            viewModel.injectContext(modelContext: modelContext)
        }
        .toolbar(content: { 
            ToolbarItem(placement: .topBarTrailing) { 
                Button { 
                    viewModel.addItem()
                } label: { 
                    Image(systemName: "plus")
                }
            }
        })
        .navigationTitle("课表时间设置")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}
