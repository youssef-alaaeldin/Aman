//
//  ImageSlider.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 10/08/2024.
//

import SwiftUI

struct ImageSlider: View {
    
    let images : [String]
    @State private var currentIndex = 0
    var body: some View {
        
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<images.count, id:\.self) {
                    index in
                    
                    Image(images[index])
                        .resizable()
                        .renderingMode(.original)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            
        }
        .frame(height: 375)
    }
}

#Preview {
    ImageSlider(images: ["1", "2" ,"3", "4"])
}
