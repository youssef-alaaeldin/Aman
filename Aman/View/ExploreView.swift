//
//  ExploreView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject var properties = PropertyViewModel()
    
    @State private var searchValue: String = ""
    @State private var selectedChoice : Property.PropertyType = .All
    
    @EnvironmentObject var coordinator: Coordinator
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 24) {
                searchBar
                banners
                
                FilterButtonsView(selectedChoice: $selectedChoice)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(properties.filterProperties(by: selectedChoice), id: \.id) { prop in
                        PropertyCardView(property: prop)
                            .onTapGesture {
                                coordinator.showPropertyDetails(for: prop)
                            }
                            
                            
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Explore")
        }
    }
    
    var banners: some View {
        
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 15) {
                    ForEach(0..<6, id: \.self) { index in
                        Image("Banner")
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                scrollViewProxy.scrollTo(2, anchor: .center)
            }
            
        }
        .scrollIndicators(.hidden)
    }
    
    var searchBar: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .offset(x: 10)
            
            TextField(text: $searchValue) {
                
                Text("Search real estate")
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

#Preview {
    ExploreView()
}
