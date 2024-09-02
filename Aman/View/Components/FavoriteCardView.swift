//
//  FavoriteCardView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 12/08/2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct FavoriteCardView: View {
    
    let property: Property
    @State var isFavorite = false
    @EnvironmentObject private var propertyViewModel : PropertyViewModel
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
        
//        VStack {
            HStack {
//                Image(property.imageUrls.first!)
                WebImage(url: URL(string: property.imageUrls.first ?? "" ))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 118, height: 118)
                    .clipShape(.rect(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    HStack  {
                        HStack(spacing: 3) {
                            Image(systemName: "house")
                            Text(property.type.rawValue)
                        }
                        .font(FontStyles.Body.xSmallMedium)
                        .foregroundStyle(Colors.Neutrals.n600)
                        
                        Spacer()
                        
                        FavoriteButton(isFavorite: $isFavorite, action: {
                            withAnimation {
                                isFavorite.toggle()
                                propertyViewModel.toggleFavorite(for: property)
                            }
                        })
//                        Spacer()
                    }
                    
                    Text(property.price.formattedAsCurrency())
                        .foregroundStyle(Colors.Primary.p500)
                        .font(FontStyles.Body.smallBold)
                    
                    Text(property.name)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .font(FontStyles.Body.smallBold)
                        .foregroundStyle(Colors.Neutrals.n900)
                    
                    HStack(spacing: 3)  {
                        Image(systemName: "location")
                        Text(property.location)
                    }
                    .font(FontStyles.Body.xSmallRegular)
                    .foregroundStyle(Colors.Neutrals.n600)
                    .padding(.top, 2)
                    
                    
                }
            }
//        }
        .padding(.all, 10)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Colors.Neutrals.n200, lineWidth: 1)
               
        )
        .onAppear {
            isFavorite = propertyViewModel.favorites.contains(where: { $0.id == property.id })
        }
        .onChange(of: isFavorite) { oldValue, newValue in
            propertyViewModel.loadFavorites()
        }
        .onTapGesture {
            coordinator.showPropertyDetails(for: property)
        }

        
        
    }
}

//#Preview {
//    FavoriteCardView(property: Property(id: nil, name: "Youssef ", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Apartment, price: 553221, location: "Tagmo3", numberOfBedrooms: 3, numberOfBathrooms: 1, size: 255, images: ["1", "2", "3", "4"]))
//}
