//
//  ExploreView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

struct ExploreView: View {
    @State private var selectedTab: Tab = .Explore
    
    
    var body: some View {
        VStack {
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    ExploreView()
}
