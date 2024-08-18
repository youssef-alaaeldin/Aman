//
//  FavoriteButton.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 15/08/2024.
//

import SwiftUI

struct FavoriteButton: View {
    
    @Binding var isFavorite: Bool
    var action : () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(.white)
                .shadow(radius: 10)
                .overlay (alignment: .center) {
                    Image(isFavorite ? "Heart" : "Favorite")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
            
        }
    }
}

//#Preview {
//    FavoriteButton()
//}
