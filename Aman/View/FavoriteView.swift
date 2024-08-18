//
//  FavoriteView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject private var properties : PropertyViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if !properties.favorites.isEmpty {
                    ForEach(properties.favorites, id: \.id) {
                        prop in
                        FavoriteCardView(property: prop)
                    }
                }
                else {
                    Text("No favorites yet, add some!")
                        .font(FontStyles.Heading.h3)
                        .foregroundStyle(Colors.Neutrals.n900)
                }
            }
            Spacer()
        }
        .navigationTitle("Favorites")
        
        .padding()
        .onAppear {
            
        }
        //        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoriteView()
}
