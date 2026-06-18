//
//  PeriodSettingRow.swift
//  LightTable
//
//  Created by 空白 on 2026/6/18.
//

import SwiftUI

struct PeriodSettingRow: View {
    @Bindable var period: Period
    
    @State private var startTimeDraft: Date
    @State private var endTimeDraft: Date
    
    init(period: Period) {
        self.period = period
        
        let calendar = Calendar.current
        let now = Date()
        
        let startHour = period.startTimeMinutes / 60
        let startMinute = period.startTimeMinutes % 60
        let startComponents = DateComponents(hour: startHour, minute: startMinute)
        _startTimeDraft = State(initialValue: calendar.nextDate(after: now, matching: startComponents, matchingPolicy: .nextTime) ?? now)
        
        let endHour = period.endTimeMinutes / 60
        let endMinute = period.endTimeMinutes % 60
        let endComponents = DateComponents(hour: endHour, minute: endMinute)
        _endTimeDraft = State(initialValue: calendar.nextDate(after: now, matching: endComponents, matchingPolicy: .nextTime) ?? now)
    }
    
    private var isTimeValid: Bool {
        let calendar = Calendar.current
        let startMin = calendar.component(.hour, from: startTimeDraft) * 60 + calendar.component(.minute, from: startTimeDraft)
        let endMin = calendar.component(.hour, from: endTimeDraft) * 60 + calendar.component(.minute, from: endTimeDraft)
        return startMin < endMin
    }
    
    var body: some View {
        DisclosureGroup("第 \(period.period) 节") {
            Group {
                DatePicker("开始时间", selection: $startTimeDraft, displayedComponents: [.hourAndMinute])
                DatePicker("结束时间", selection: $endTimeDraft, displayedComponents: [.hourAndMinute])
            }
            .foregroundStyle(isTimeValid ? Color.primary : Color.red)
            .onChange(of: startTimeDraft) { _, newValue in
                if isTimeValid {
                    updateModel()
                }
            }
            .onChange(of: endTimeDraft) { _, newValue in
                if isTimeValid {
                    updateModel()
                }
            }
        }
    }
    
    private func updateModel() {
        let calendar = Calendar.current
        let startHour = calendar.component(.hour, from: startTimeDraft)
        let startMinute = calendar.component(.minute, from: startTimeDraft)
        period.startTimeMinutes = startHour * 60 + startMinute
        
        let endHour = calendar.component(.hour, from: endTimeDraft)
        let endMinute = calendar.component(.minute, from: endTimeDraft)
        period.endTimeMinutes = endHour * 60 + endMinute
    }
}
