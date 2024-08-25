//
//  ExploreView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .Explore
    @State var navigationTitle = "Explore"
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    
                        ExploreView()
                            .tag(Tab.Explore)
                            
                        FavoriteView()
                            .tag(Tab.Favorite)
                        AccountView()
                            .tag(Tab.Account)
                    
                }
            }
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(selectedTab == .Explore ? "Explore" : selectedTab == .Favorite ? "Favorites" : "Profile")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            Button {
                // ADD PROPERTY FOR ADMIN
                self.coordinator.present(sheet: .addProperty)
            } label: {
                if selectedTab == .Explore {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    MainView()
}
