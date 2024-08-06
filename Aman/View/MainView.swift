//
//  ExploreView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .Explore
    
//    
//    init() {
////        UITabBar.appearance().isHidden = true
//    }
    
    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    switch selectedTab {
                    case .Explore:
                        NavigationStack {
                            ExploreView()
                        }
                    case .Favorite:
                        NavigationStack {
                            FavoriteView()
                        }
                    case .Account:
                        NavigationStack {
                            AccountView()
                        }
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
