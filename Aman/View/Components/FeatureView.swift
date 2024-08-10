//
//  FeatureView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 10/08/2024.
//

import SwiftUI

import SwiftUI

struct FeaturesView: View {
    
    @Binding var isViewMorePressed : Bool
    var body: some View {
            
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                    FeatureItemView(iconName: "bed.double", label: "2 Beds")
                    FeatureItemView(iconName: "shower", label: "3 Baths")
                    FeatureItemView(iconName: "car.fill", label: "Garage")
                    FeatureItemView(iconName: "refrigerator", label: "Kitchen")
                    FeatureItemView(iconName: "square.grid.2x2", label: "Balcony")
                    FeatureItemView(iconName: "leaf.fill", label: "Garden")
                    
                    if isViewMorePressed {
                        FeatureItemView(iconName: "refrigerator", label: "Kitchen")
                        FeatureItemView(iconName: "square.grid.2x2", label: "Balcony")
                        FeatureItemView(iconName: "leaf.fill", label: "Garden")
                    }
                }
                .padding()
                
                Button(action: {
                    // Handle view more action
                    withAnimation {
                        isViewMorePressed.toggle()
                    }
                }) {
                    Text(isViewMorePressed ? "View less" : "View more")
                        .font(.callout)
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 20)
            }
            .background(Colors.Neutrals.n100)
            .cornerRadius(10)
    }
}

struct FeatureItemView: View {
    let iconName: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(Colors.Neutrals.n600)
            
            Text(label)
                .font(.body)
                .foregroundColor(Colors.Neutrals.n900)
        }
    }
}

struct FeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesView(isViewMorePressed: .constant(true))
    }
}

