//
//  ExploreView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreView: View {
    
    @EnvironmentObject var properties : PropertyViewModel
    
    @State private var searchValue: String = ""
    @State private var selectedChoice : Property.PropertyType = .All
    @State private var navigatingToSearchView = false
    @FocusState private var isSearchFieldFocus : Bool
    
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var isLoading = true
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 24) {
                
                
                SearchBar(searchValue: $searchValue, title: "Search")
                    .focused($isSearchFieldFocus)
                    .onTapGesture {
                        navigatingToSearchView = true
                        coordinator.push(.searchView)
                    }
                    .onChange(of: navigatingToSearchView) { oldValue, newValue in
                        if newValue {
                            isSearchFieldFocus = false
                        }
                    }
                banners
                
                FilterButtonsView(selectedChoice: $selectedChoice)
                
                propertiesList
                    .redacted(reason: properties.isLoading ? .placeholder : [])
                
                Spacer()
            }
        }
        .onAppear {
            print("properties : \(properties.properties.count)")
            print(" favorites : \(properties.favorites.count)")
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
    
    
    var propertiesList: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(properties.filterProperties(by: selectedChoice), id: \.id) { prop in
                PropertyCardView(property: prop)
                    .onTapGesture {
                        coordinator.showPropertyDetails(for: prop)
                    }
            }
        }
    }
    
    
    
}

#Preview {
    ExploreView()
}
