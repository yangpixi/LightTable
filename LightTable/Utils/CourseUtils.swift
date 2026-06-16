//
//  CourseUtils.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import SwiftUI

struct CourseUtils {
    static func coursesFor(weekday: Int, week: Int, in courses: [Course]) -> [Course] {
        courses
            .filter { course in
                course.weekday == weekday &&
                course.weekInterval.contains(week)
            }
            .sorted { ($0.period.first ?? 0) < ($1.period.first ?? 0) }
    }
}
