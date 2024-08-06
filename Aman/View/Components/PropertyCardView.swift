//
//  PropertyCardView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 06/08/2024.
//

import SwiftUI

struct PropertyCardView: View {
    
    @State var isFavorite = false
    var body: some View {
        
        //            ZStack (alignment: .top)  {
        //                RoundedRectangle(cornerRadius: 15)
        //
        //                    .foregroundStyle(Colors.Neutrals.n50)
        //                    .overlay(
        //                        RoundedRectangle(cornerRadius: 15)
        //                            .stroke(Colors.Neutrals.n200, lineWidth: 1)
        //                    )
        //
        //                VStack(alignment: .leading) {
        //                    Image("4")
        //                        .resizable()
        //                        .aspectRatio(contentMode: .fill)
        //                        .frame(width: 140, height: 146)
        //                        .clipShape(.rect(cornerRadius: 10))
        //                        .padding(.all , 11)
        //
        //                    Button {
        //                        withAnimation {
        //                            isFavorite.toggle()
        //                        }
        //                    } label: {
        //                        Circle()
        //                            .frame(width: 32, height: 32)
        //                            .foregroundStyle(.white)
        //                            .shadow(radius: 10)
        //                            .overlay (alignment: .center) {
        //                                Image(isFavorite ? "Favorite-fill" : "Favorite")
        //                                    .resizable()
        //                                    .frame(width: 20, height: 20)
        //                            }
        //                    }
        //                    .position(x: 120, y: -20)
        //
        //                    HStack {
        //                        Image(systemName: "house")
        //                        Text("HOUSE")
        //                    }
        //                }
        //
        //            }
        //            .frame(width: 162, height: 268)
        //
        //
        ZStack ( alignment: .top) {
            
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Colors.Neutrals.n50)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Colors.Neutrals.n200, lineWidth: 1)
                )
//                .frame(width: 162, height: 268)
            
            VStack ( alignment: .leading, spacing: 5) {
                ZStack {
                    Image("4")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 146)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.all , 11)
                    
                    Button {
                        withAnimation {
                            isFavorite.toggle()
                        }
                    } label: {
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.white)
                            .shadow(radius: 10)
                            .overlay (alignment: .center) {
                                Image(isFavorite ? "Favorite-fill" : "Favorite")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            
                        
                    }
                    .offset(x: 40, y: 69)
                    
                }
//                VStack (spacing: 5) {
                Group {
                    HStack {
                        Image(systemName: "house")
                        Text("HOUSE")
                    }
                    .foregroundStyle(Colors.Neutrals.n600)
                    
                    .font(FontStyles.Body.smallRegular)
                    Text("$307,857")
                        .font(FontStyles.Body.smallBold)
                        .foregroundStyle(Colors.Primary.p500)
                    
                    Text("Rumah pakuwon city megahas")
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .font(FontStyles.Body.smallBold)
                        .foregroundStyle(Colors.Neutrals.n900)
                    
                    HStack {
                        Image(systemName: "location")
                        Text("Location")
                    }
                    .font(FontStyles.Body.xSmallRegular)
                    .foregroundStyle(Colors.Neutrals.n600)
                    .padding(.top, 5)
                }
                .padding(.horizontal, 10)
//                }
//                .padding(.horizontal, 5)
            }
            
        }
        .frame(width: 162, height: 268)
        
    }
}

#Preview {
    PropertyCardView()
}
