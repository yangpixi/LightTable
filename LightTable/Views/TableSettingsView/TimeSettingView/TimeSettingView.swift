import SwiftUI
import SwiftData

struct TimeSettingView: View {
    @Query(sort: \Period.period, order: .forward) private var periods: [Period]
    
    var body: some View {
        List {
            ForEach(periods) { period in
                PeriodSettingRow(period: period)
            }
        }
        .navigationTitle("课表时间设置")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}
