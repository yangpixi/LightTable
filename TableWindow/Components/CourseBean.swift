//
//  CouseBean.swift
//  LightTable
//
//  Created by 空白 on 2026/6/19.
//

import SwiftUI

struct CourseBean: View {
    private let course: Course
    private let period: String
    
    init(course: Course, period: String) {
        self.course = course
        self.period = period
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(course.name)")
            Text("\(course.location.isEmpty ? course.teacher : course.location)")
            Text(period)
                .foregroundStyle(.gray)
        }
        .font(.footnote)
    }
    
}
