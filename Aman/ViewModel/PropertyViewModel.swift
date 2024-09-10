//
//  PropertyViewModel.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 07/08/2024.
//

import Foundation
import Combine
import SwiftUI


class PropertyViewModel: ObservableObject {
    @Published var properties: [Property] = []
    @Published var favorites: [Property] = []
    @Published var searchedProperties: [Property] = []
    @Published var isLoading = true
    
    private let propertyService = PropertyService()
    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()
    
    
    
    init() {
        loadProperties()
        loadFavorites()
    }
    
    func loadProperties() {
        propertyService.fetchProperties { [weak self] result in
            switch result {
            case .success(let properties):
                self?.isLoading = false
                self?.properties = properties
            case .failure(let error):
                print("Error fetching properties: \(error)")
            }
        }
    }
    
    func loadFavorites() {
        userService.fetchFavoriteProperties { [weak self] result in
            switch result {
            case .success(let favorites):
                self?.favorites = favorites
            case .failure(let error):
                print("Error fetching favorites: \(error)")
            }
        }
    }
    
    func toggleFavorite(for property: Property) {
        if favorites.contains(where: { $0.id == property.id }) {
            removeFavorite(property: property)
        } else {
            addFavorite(property: property)
        }
    }
    
    private func addFavorite(property: Property) {
        guard let propertyID = property.id else { return }
        userService.addFavorite(propertyID: propertyID) { [weak self] result in
            switch result {
            case .success:
                self?.favorites.append(property)
            case .failure(let error):
                print("Error adding favorite: \(error)")
            }
        }
    }
    
    private func removeFavorite(property: Property) {
        guard let propertyID = property.id else { return }
        userService.removeFavorite(propertyID: propertyID) { [weak self] result in
            switch result {
            case .success:
                self?.favorites.removeAll { $0.id == property.id }
            case .failure(let error):
                print("Error removing favorite: \(error)")
            }
        }
    }
    
    func filterProperties(by type: Property.PropertyType) -> [Property] {
        
        if type == .All {
            return properties
        } else {
            return properties.filter { $0.type == type }
        }
    }
    
    func filterPropertiesSearch(by type: Property.PropertyType) {
        if type == .All {
            searchedProperties = properties
        } else {
            searchedProperties = properties.filter { $0.type == type }
        }
    }
    
    func filterPropertiesByPriceRange(minPrice: Double, maxPrice: Double) {
        searchedProperties = searchedProperties.filter { $0.price >= minPrice && $0.price <= maxPrice }
    }
    
    func filterPropertiesByArea(minArea: Double, maxArea: Double) {
        searchedProperties = searchedProperties.filter { $0.size >= minArea && $0.size <= maxArea }
    }
    
    func filterPropertiesByBedrooms(_ numberOfBedrooms: Int) {
        searchedProperties = searchedProperties.filter { $0.numberOfBedrooms == numberOfBedrooms }
    }
    
    func filterPropertiesByBathrooms(_ numberOfBathrooms: Int) {
        searchedProperties = searchedProperties.filter { $0.numberOfBathrooms == numberOfBathrooms }
    }
    
    
    func sortProperties(by option: SortOptions) {
        switch option {
        case .None:
            break
        case .Newest:
            break
        case .HighestPrice:
            searchedProperties.sort { $0.price > $1.price }
        case .LoestPrice:
            searchedProperties.sort { $0.price < $1.price }
        }
    }
    
    func applyFilters(type: Property.PropertyType, minPrice: Double, maxPrice: Double, minArea: Double, maxArea: Double, bedrooms: Int, bathrooms: Int, sortOption: SortOptions) {
        filterPropertiesSearch(by: type)
        filterPropertiesByPriceRange(minPrice: minPrice, maxPrice: maxPrice)
        filterPropertiesByArea(minArea: minArea, maxArea: maxArea)
        filterPropertiesByBedrooms(bedrooms)
        filterPropertiesByBathrooms(bathrooms)
        sortProperties(by: sortOption)
    }
    
    func searchProperty(by description: String) {
        searchedProperties.removeAll()
        searchedProperties = properties.filter { $0.description.localizedCaseInsensitiveContains(description)}
    }
    
    func addProperty(
        name: String,
        description: String,
        type: Property.PropertyType,
        price: Double,
        location: String,
        numberOfBedrooms: Int,
        numberOfBathrooms: Int,
        size: Double,
        images: [String],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let property = Property(
            id: nil,
            name: name,
            description: description,
            type: type,
            price: price,
            location: location,
            numberOfBedrooms: numberOfBedrooms,
            numberOfBathrooms: numberOfBathrooms,
            size: size,
            imageUrls: images,
            date: Date()
        )
        
        propertyService.addProperty(property) { [weak self] result in
            
            switch result {
            case .success:
                // Append the new property to the published properties array
                self?.properties.append(property)
                completion(.success(()))
            case .failure(let error):
                print("Error adding property: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func deleteProperty(_ property: Property, completion: @escaping (Bool) -> Void) {
            guard let propertyID = property.id else { return }
            
        propertyService.deleteProperty(propertyID: propertyID) { [weak self] result in
                    switch result {
                    case .success:
                        self?.properties.removeAll { $0.id == property.id }
                        self?.searchedProperties.removeAll { $0.id == property.id }
                        self?.favorites.removeAll { $0.id == property.id }
                        print("Property deleted successfully.")
                        completion(true)  // Indicate success
                    case .failure(let error):
                        print("Error deleting property: \(error)")
                        completion(false)  // Indicate failure
                    }
                }
        }
}

