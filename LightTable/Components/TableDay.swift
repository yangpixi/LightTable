//
//  TableDay.swift
//  LightTable
//
//  Created by 空白 on 2026/6/15.
//

import SwiftUI

struct TableDay: View {
    
    private let weekday: String
    private let day: Int
    
    init(weekday: String, day: Int) {
        self.weekday = weekday
        self.day = day
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(weekday)
                .bold()
            Text("\(day)")
                .font(.footnote)
                .foregroundStyle(.gray)
        }
    }
}
