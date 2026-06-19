//
//  Title.swift
//  LightTable
//
//  Created by 空白 on 2026/6/19.
//

import SwiftUI

struct Title: View {
    
    private let term: String
    private let date: String
    private let week: Int
    
    init(term: String, date: String, week: Int) {
        self.term = term
        self.date = date
        self.week = week
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(term)
                .lineLimit(1)
            Text(" | \(date) ")
                .layoutPriority(2)
            Text("\(week)周")
                .bold()
                .foregroundStyle(.red)
                .layoutPriority(2)
        }
        .font(.footnote)
    }
}
