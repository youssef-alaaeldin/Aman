//
//  PropertyDelatisView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 07/08/2024.
//

import SwiftUI

struct PropertyDelatisView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    let property : Property
    
    var body: some View {
        
        ScrollView {
            
            VStack (alignment: .leading, spacing: 0) {
                Image(property.imageURL)
                    .resizable()
                    .frame(height: 375)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        HStack {
                            Image(systemName: "house")
                            Text(property.type.rawValue)
                        }
                        Spacer()
                        Button {
                            withAnimation {
//                                isFavorite.toggle()
                            }
                        } label: {
                            Circle()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(.white)
                                .shadow(radius: 10)
                                .overlay (alignment: .center) {
                                    Image("Favorite")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                }
                                
                            
                        }
                    }
                    
                    Text(property.price.formattedAsCurrency())
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Text(property.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "location")
                        Text(property.location)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
               Spacer()
            }
            
        }
        .overlay(
            TopNavBar {
                coordinator.pop()
            }
        )
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    PropertyDelatisView(property: Property(id: UUID(), name: "Youssef alaa", type: .Apartment, price: 553221, location: "Tagmo3", numberOfBedrooms: 3, numberOfBathrooms: 1, size: 255, imageURL: "2"))
}
