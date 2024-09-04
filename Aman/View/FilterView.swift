//
//  FilterView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 02/09/2024.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State private var selectedType: Property.PropertyType = .All
    @State private var minPrice: Double = 0
    @State private var maxPrice: Double = 1_000_000
    
    @State private var minArea: Double = 0
    @State private var maxArea: Double = 10_000
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Filters & Sort")
                    Spacer()
                    Button {
                        coordinator.dismissSheet()
                    } label: {
                        Image(systemName: "multiply")
                            .frame(width: 24, height: 24)
                    }
                    
                }
                .font(FontStyles.Body.xLargeBold)
                .foregroundStyle(Colors.Neutrals.n900)
                
                Divider()
                
                categorySection
                
                Divider()
                
                priceSection
                
                Divider()
                
                areaSection
            }
            .padding()
        }
        
    }
    
    var categorySection : some View {
        Group {
            Text("Category")
                .font(FontStyles.Body.largeMedium)
                .foregroundStyle(Colors.Neutrals.n900)
            
            FilterButtonsView(selectedChoice: $selectedType)
        }
    }
    
    var priceSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Price")
                .font(FontStyles.Body.largeMedium)
                .foregroundStyle(Colors.Neutrals.n900)
            
            Text("\(minPrice.formattedAsCurrency()) - \(maxPrice.formattedAsCurrency())")
                .font(FontStyles.Body.mediumRegular)
                .foregroundStyle(Colors.Neutrals.n600)
            

            
            RangeSliderView(minValue: $minPrice, maxValue: $maxPrice, range: 0...1_000_000, step: 10_000)
            
                
        }
    }
    
    var areaSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Living area")
                .font(FontStyles.Body.largeMedium)
                .foregroundStyle(Colors.Neutrals.n900)
            
            Text("\(minArea.formatted()) - \(maxArea.formatted())")
                .font(FontStyles.Body.mediumRegular)
                .foregroundStyle(Colors.Neutrals.n600)
            
            RangeSliderView(minValue: $minArea, maxValue: $maxArea, range: 0...10_000, step: 100)
        }
    }
    
}

#Preview {
    FilterView()
}
