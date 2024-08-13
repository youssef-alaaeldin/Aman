//
//  FavoriteView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

struct FavoriteView: View {
    
    @StateObject private var properties = PropertyViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(properties.properties, id: \.id) {
                    prop in
                    
                    FavoriteCardView(property: prop)
                }
                Spacer()
            }
            .navigationTitle("Favorites")
            
            
        }
        .padding()
//        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoriteView()
}
