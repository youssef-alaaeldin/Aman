//
//  PropertyCardView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 06/08/2024.
//

import SwiftUI

enum PropertyIcon {
    
}

struct PropertyCardView: View {
    let property : Property
    @State var isFavorite = false
    
    var body: some View {
        
       
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
                    Image(property.imageURL)
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
                        Text(property.type.rawValue)
                    }
                    .foregroundStyle(Colors.Neutrals.n600)
                    
                    .font(FontStyles.Body.smallRegular)
                    Text(property.price.formattedAsCurrency())
                        .font(FontStyles.Body.smallBold)
                        .foregroundStyle(Colors.Primary.p500)
                    
                    Text(property.name)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .font(FontStyles.Body.smallBold)
                        .foregroundStyle(Colors.Neutrals.n900)
                    
                    HStack {
                        Image(systemName: "location")
                        Text(property.location)
                    }
                    .font(FontStyles.Body.xSmallRegular)
                    .foregroundStyle(Colors.Neutrals.n600)
                    .padding(.top, 5)
                }
                .padding(.horizontal, 10)
            }
            
        }
        .frame(width: 162, height: 268)
        
    }
}

#Preview {
    PropertyCardView(property: Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Apartment, price: 553221, location: "Tagmo3", numberOfBedrooms: 3, numberOfBathrooms: 1, size: 255, imageURL: "2"))
}

extension Double {
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale(identifier: "en_US") // You can change this to your desired locale
        return formatter.string(from: NSNumber(value: self)) ?? "$0"
    }
}
