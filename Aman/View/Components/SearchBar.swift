//
//  SearchBar.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 01/09/2024.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchValue : String
    var title: String
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .offset(x: 10)
            
            TextField(text: $searchValue) {
                
                Text(title)
                    .font(FontStyles.Body.mediumRegular)
                    .foregroundStyle(Colors.Neutrals.n600)
            }
            .padding()
            .clipShape(.rect(cornerRadius: 8))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Colors.Neutrals.n200, lineWidth: 1)
        )
        .padding()
    }
}

//#Preview {
//    SearchBar()
//}
