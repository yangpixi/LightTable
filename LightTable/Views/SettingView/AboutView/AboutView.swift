//
//  AboutView.swift
//  LightTable
//
//  Created by 空白 on 2026/7/5.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            VStack(spacing: 2) {
                Image("icons")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("LightTable")
                    .font(.title2)
                    .bold()
                
                Text("V \(Bundle.main.fullVersionString)")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .frame(maxHeight: .infinity, alignment: .center)
            .padding(.top, -40) 
            
            Text("Copyright © 2026 yangpixi. All rights reserved.")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("关于")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}

#Preview {
    AboutView()
}

