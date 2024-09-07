//
//  FilterView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 02/09/2024.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var properties: PropertyViewModel
    @State private var selectedType: Property.PropertyType = .All
    @State private var minPrice: Double = 0
    @State private var maxPrice: Double = 1_000_000
    
    @State private var minArea: Double = 0
    @State private var maxArea: Double = 10_000
    
    @State private var bathroom = 1
    @State private var bedrooms = 2
    
    @State private var selectedSort: SortOptions = .None
    
    
    
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
                
                Divider()
                
                facilitiesSection
                
                Divider()
                
                sortSection
                
                Divider()
                
                applySection
            }
            .padding()
        }
        .onAppear {
//            saveFilterValues()
            loadFilterValues()  // Load filter values from UserDefaults when the view appears
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
    
    var facilitiesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Facilities")
                .font(FontStyles.Body.largeMedium)
                .foregroundStyle(Colors.Neutrals.n900)
            
            CustomStepper(value: $bathroom, title: "Bathroom")
            
            CustomStepper(value: $bedrooms, title: "Bedroom")
            
        }
    }
    
    var sortSection: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("Sort")
                .font(FontStyles.Body.largeMedium)
                .foregroundStyle(Colors.Neutrals.n900)
            
            SortButtons(selectedChoice: $selectedSort)
        }
    }
    
    var applySection: some View {
        HStack(alignment: .center) {
            
            Button {
                resetFilters()
            } label: {
                Text("Reset")
                    .foregroundStyle(Colors.Primary.p200)
            }
            .frame(width: 98, height: 52)
            .background(Colors.Neutrals.n50)
            .clipShape(.rect(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Colors.Neutrals.n200, lineWidth: 1)
            )
            Button {
                //APPLY FILTERS
                applyFilters()
            } label: {
                Text("Apply")
                    .font(FontStyles.Body.mediumBold)
                    .foregroundStyle(Colors.Neutrals.n50)
            }
            .frame(width: 255, height: 52)
            .background(Colors.Primary.p500)
            .clipShape(.rect(cornerRadius: 8))
        }
            
        
    }
    
    private func resetFilters() {
        minPrice = 0
        maxPrice = 1_000_000
        minArea = 0
        maxArea = 10_000
        bedrooms = 2
        bathroom = 1
        selectedType = .All
        selectedSort = .None
        
        saveFilterValues()
    }
    
    private func applyFilters() {
        print(" max area: \(maxArea)")
        print(" min area: \(minArea)")
        print(" max price: \(maxPrice)")
        print(" min price: \(minPrice)")
        print(" applied category: \(selectedType)")
        print(" applied sort: \(selectedSort)")
        print(" beedrooms: \(bedrooms)")
        print(" bathrooms: \(bathroom)")
        
        saveFilterValues()
        
        
        properties.applyFilters(type: selectedType, minPrice: minPrice, maxPrice: maxPrice, minArea: minArea, maxArea: maxArea, bedrooms: bedrooms, bathrooms: bathroom, sortOption: selectedSort)
        
        coordinator.dismissSheet()
    }
    
    // MARK: - UserDefaults Handling
    
    private func loadFilterValues() {
        if let typeRawValue = UserDefaults.standard.string(forKey: Filters.selectedTypeKey),
               let savedType = Property.PropertyType(rawValue: typeRawValue) {
                selectedType = savedType
            }
        minPrice = UserDefaults.standard.double(forKey: Filters.minPriceKey)
        maxPrice = UserDefaults.standard.double(forKey: Filters.maxPriceKey)
        minArea = UserDefaults.standard.double(forKey: Filters.minAreaKey)
        maxArea = UserDefaults.standard.double(forKey: Filters.maxAreaKey)
        bathroom = UserDefaults.standard.integer(forKey: Filters.bathroomKey)
        bedrooms = UserDefaults.standard.integer(forKey: Filters.bedroomsKey)
        if let sortRawValue = UserDefaults.standard.string(forKey: Filters.selectedSortKey),
               let savedSort = SortOptions(rawValue: sortRawValue) {
                selectedSort = savedSort
            }
        }
        
        private func saveFilterValues() {
            UserDefaults.standard.set(selectedType.rawValue, forKey: Filters.selectedTypeKey)
            UserDefaults.standard.set(minPrice, forKey: Filters.minPriceKey)
            UserDefaults.standard.set(maxPrice, forKey: Filters.maxPriceKey)
            UserDefaults.standard.set(minArea, forKey: Filters.minAreaKey)
            UserDefaults.standard.set(maxArea, forKey: Filters.maxAreaKey)
            UserDefaults.standard.set(bathroom, forKey: Filters.bathroomKey)
            UserDefaults.standard.set(bedrooms, forKey: Filters.bedroomsKey)
            UserDefaults.standard.set(selectedSort.rawValue, forKey: Filters.selectedSortKey)
            
            print("Saved successfully")
        }
}

#Preview {
    FilterView()
}
