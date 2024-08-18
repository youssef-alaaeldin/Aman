//
//  PropertyViewModel.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 07/08/2024.
//

import Foundation
import Combine

//class PropertyViewModel : ObservableObject {
//
//    @Published var properties : [Property] = []
//
//    init() {
//        loadProperties()
//    }
//
//    func loadProperties() {
//        properties = [
//            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Apartment, price: 123123, location: "Tagmo3", numberOfBedrooms: 2, numberOfBathrooms: 3, size: 125, images: ["1", "2", "3", "4"]),
//
//            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Villa, price: 24432, location: "Tagmo3", numberOfBedrooms: 1, numberOfBathrooms: 2, size: 148, images: ["2", "1", "3", "4"]),
//
//            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .House, price: 554332, location: "Fesal", numberOfBedrooms: 3, numberOfBathrooms: 2, size: 100, images: ["3", "2", "1", "4"]),
//
//            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Villa, price: 433355, location: "helmya", numberOfBedrooms: 2, numberOfBathrooms: 3, size: 123, images: ["4", "3", "2", "1"]),
//
//            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Apartment, price: 553221, location: "Tagmo3", numberOfBedrooms: 3, numberOfBathrooms: 1, size: 255, images: ["1", "2", "3", "4"])
//        ]
//
//    }
//
//    func filterProperties(by type: Property.PropertyType) -> [Property] {
//
//        if type == .All {
//            return properties
//        } else {
//            return properties.filter { $0.type == type }
//        }
//    }
//}




// CHATGPT


class PropertyViewModel: ObservableObject {
    @Published var properties: [Property] = []
    @Published var favorites: [Property] = []
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
    
    func addSampleData() {
        propertyService.addSampleData()
    }
}

