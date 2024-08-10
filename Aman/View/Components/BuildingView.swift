//
//  DetailsRectangleHelper.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 10/08/2024.
//

import SwiftUI

struct BuildingView: View {
    let property : Property
    var body: some View {
        VStack {
            HStack {
                Text("Type")
                    .foregroundStyle(Colors.Neutrals.n900)
                Spacer()
                Text(property.type.rawValue)
                    .foregroundStyle(Colors.Neutrals.n600)
            }
            Divider()
                .foregroundStyle(Colors.Neutrals.n200)
            HStack {
                Text("Year Built")
                    .foregroundStyle(Colors.Neutrals.n900)
                Spacer()
                Text("2017")
                    .foregroundStyle(Colors.Neutrals.n600)
                
            }
            Divider()
                .foregroundStyle(Colors.Neutrals.n200)
            HStack {
                Text("Living area")
                    .foregroundStyle(Colors.Neutrals.n900)
                Spacer()
                Text("\(property.size.formatted())")
                    .foregroundStyle(Colors.Neutrals.n600)
            }
        }
        .padding()
        .background(Colors.Neutrals.n100)
        .cornerRadius(12)
    }
}
#Preview {
    BuildingView(property: Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families.. Read more", type: .Apartment, price: 553221, location: "Tagmo3", numberOfBedrooms: 3, numberOfBathrooms: 1, size: 255, imageURL: "2"))
}
