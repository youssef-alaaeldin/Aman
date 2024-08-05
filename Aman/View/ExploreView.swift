//
//  ExploreView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var searchValue: String = ""
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack(spacing: 0) {
                    Image(systemName: "magnifyingglass")
                        .offset(x: 10)
                    
                    TextField(text: $searchValue) {
                        
                        Text("Search real estate")
                            .font(FontStyles.Body.mediumRegular)
                            .foregroundStyle(Colors.Neutrals.n600)
                    }
                    .padding()
                    //            .background(Colors.Neutrals.n100)
                    .clipShape(.rect(cornerRadius: 8))
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Colors.Neutrals.n200, lineWidth: 1)
                )
                
                Spacer()
            }
            .padding()
        .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExploreView()
}
