//
//  ExploreView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .Explore
    
    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    Group {
                        ExploreView()
                            .tag(Tab.Explore)
                        
                        FavoriteView()
                            .tag(Tab.Favorite)
                        AccountView()
                            .tag(Tab.Account)
                    }
                }
            }
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainView()
}
