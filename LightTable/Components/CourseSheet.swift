//
//  CourseSheet.swift
//  LightTable
//
//  Created by 空白 on 2026/7/5.
//

import SwiftUI
import SwiftData

struct CourseSheet: View {
    @Query private var periods: [Period]
    
    private var course: Bindable<Course>
    @State private var showPopover: Bool = false
    
    init(_ course: Bindable<Course>) {
        self.course = course
    }
    
    var body: some View {
        VStack {
            List {
                LabeledContent {
                    TextField("请输入课表名称", text: course.name)
                        .multilineTextAlignment(.trailing)
                } label: {
                    Text("课程名称")
                }
                
                LabeledContent {
                    TextField("请输入上课地点", text: course.location)
                        .multilineTextAlignment(.trailing)
                } label: {
                    Text("上课地点")
                }
                
                LabeledContent {
                    Text("\(course.period.first?.wrappedValue ?? 1) - \(course.period.last?.wrappedValue ?? 1) 节")
                        .onTapGesture {
                            showPopover = true
                        }
                } label: {
                    Text("上课时间")
                }
                .popover(isPresented: $showPopover, attachmentAnchor: .point(UnitPoint(x: 0.9, y: 1)), arrowEdge: .top) {
                    HStack {
                        ForEach(1...periods.count, id: \.self) { period in
                            if course.period.wrappedValue.contains(period) {
                                Button {
                                    course.period.wrappedValue.remove(at: period - 1)
                                } label: { 
                                    Text("\(period)")
                                        .foregroundStyle(.white)
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .background(.blue, in: Circle())
                                }
                            } else {
                                Button { 
                                    course.period.wrappedValue.insert(period, at: period - 1)
                                } label: { 
                                    Text("\(period)")
                                        .foregroundStyle(.black)
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .background(.clear, in: Circle())
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .presentationCompactAdaptation(.popover)
                    .frame(minWidth: 200, minHeight: 100)
                }
            }
        }
    }
}
