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
            Text(name)
                .font(.footnote)
            Text(location)
                .font(.footnote)
        }
        .padding(2)
    }
}
