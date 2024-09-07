//
//  PropertyDelatisView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 07/08/2024.
//

import SwiftUI

struct PropertyDelatisView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject private var viewModel: PropertyViewModel
    @State var isViewMorePress = false
    @State private var showDeleteConfirmation = false
    
   
    let property : Property
    
    var body: some View {
        
        ScrollView {
            
            VStack (alignment: .leading, spacing: 0) {
                imageSection
                
                Rectangle()
                    .fill(Colors.Neutrals.n100)
                    .frame(height: 6)
                
                ownerSection
                
                Rectangle()
                    .fill(Colors.Neutrals.n100)
                    .frame(height: 6)
                
                detailsSection
                
                Rectangle()
                    .fill(Colors.Neutrals.n100)
                    .frame(height: 6)
                
                descriptionSection
                
                Spacer()
                
                
            }
        }
        .overlay(
            TopNavBar(backAction: {
                coordinator.pop()
            }, deleteAction: {
                viewModel.deleteProperty(property) { success in
                    if success {
                        coordinator.pop()
                    } else {
                        print("Failed to delete property.")
                    }
                }
            }, showDeleteDialog: {
                showDeleteConfirmation = true
            }, showDeleteConfirmation: $showDeleteConfirmation)
                .offset(y: 50)
            
            
        )
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        
        
    }
    
    var imageSection: some View {
        VStack(alignment: .leading) {
            ImageSlider(images: property.imageUrls)
            VStack(alignment: .leading, spacing: 5) {
                
                HStack {
                    Image(systemName: "house")
                    Text(property.type.rawValue)
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
                .foregroundStyle(Colors.Neutrals.n600)
                .font(FontStyles.Body.mediumRegular )
                
                Text(property.price.formattedAsCurrency())
                    .font(FontStyles.Body.largeBold)
                    .foregroundStyle(Colors.Primary.p500)
                
                Text(property.name)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(FontStyles.Body.largeBold)
                    .foregroundStyle(Colors.Neutrals.n900)
                
                HStack {
                    Image(systemName: "location")
                    Text(property.location)
                }
                .font(FontStyles.Body.smallRegular)
                .foregroundStyle(Colors.Neutrals.n600)
                .padding(.top, 5)
            }
            .padding()
            
        }
        
    }
    
    var ownerSection: some View {
        VStack(alignment: .leading) {
            Text("Owner")
                .font(FontStyles.Body.largeBold)
                .foregroundStyle(Colors.Neutrals.n900)
            
            HStack(spacing: 12) {
                Image("woman1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Owner Name")
                        .font(FontStyles.Body.mediumBold)
                        .foregroundStyle(Colors.Neutrals.n900)
                    
                    Text("Member since 2000")
                        .font(FontStyles.Body.smallRegular)
                        .foregroundStyle(.neutrals500)
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("View Profile")
                        .foregroundStyle(Colors.Primary.p500)
                        .font(FontStyles.Body.smallBold)
                }
                .frame(width: 98, height: 33)
                .background(Colors.Neutrals.n50)
                .clipShape(.rect(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Colors.Neutrals.n200, lineWidth: 1)
                )
            }
        }
        .padding()
    }
    
    
    var detailsSection: some View {
        VStack(alignment: .leading,spacing: 12) {
            
            Text("Details")
                .font(FontStyles.Body.largeBold)
                .foregroundStyle(Colors.Neutrals.n900)
            
            Text("Building")
                .font(FontStyles.Body.smallBold)
                .foregroundStyle(Colors.Neutrals.n600)
            
            BuildingView(property: property)
            
            
            Text("Features")
                .font(FontStyles.Body.smallBold)
                .foregroundStyle(Colors.Neutrals.n600)
            
            FeaturesView(isViewMorePressed: $isViewMorePress)
        }
        .padding()
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(FontStyles.Body.largeBold)
                .foregroundStyle(Colors.Neutrals.n900)
            
            VStack {
                Text(property.description)
                    .font(FontStyles.Body.largeRegular)
                    .foregroundStyle(Colors.Neutrals.n900)
            }
            .padding()
            .background(Colors.Neutrals.n100)
            .clipShape(.rect(cornerRadius: 12))
            
                
        }
        .padding()
        
        
        
    }
}

//#Preview {
//    PropertyDelatisView(property: Property(id: nil, name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Apartment, price: 553221, location: "Tagmo3", numberOfBedrooms: 3, numberOfBathrooms: 1, size: 255, images: ["1", "2", "3", "4"]))
//}
