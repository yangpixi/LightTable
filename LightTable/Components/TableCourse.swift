//
//  TableCourse.swift
//  LightTable
//
//  Created by 空白 on 2026/6/15.
//

import SwiftUI

struct TableCourse: View {
    private let name: String
    private let location: String
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Group {
                Text(name)
                Text(location)
                    .foregroundStyle(.gray.opacity(0.9))
            }
            .font(.footnote.scaled(by: 0.9))
        }
        .padding(2)
    }
}
