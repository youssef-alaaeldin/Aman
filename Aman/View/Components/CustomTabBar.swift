//
//  CustomTabBar.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case Explore
    case Favorite
    case Account
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    
    private var fillImage: String {
        selectedTab.rawValue + "-fill"
    }
    
    var body: some View {
        
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Colors.Neutrals.n200)
            
            HStack{
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    
                    Spacer()
                    VStack {
                        Image(selectedTab == tab ? fillImage : tab.rawValue)
                        Text(tab.rawValue)
                            .font(FontStyles.Body.smallRegular)
                            .foregroundStyle(selectedTab == tab ? Colors.Primary.p500 : Colors.Neutrals.n600)
                    }
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = tab
                        }
                    }
                    Spacer()
                    
                }
            }
            .frame(height: 56)
           
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.Account))
}
