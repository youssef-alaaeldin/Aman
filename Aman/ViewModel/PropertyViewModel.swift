//
//  PropertyViewModel.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 07/08/2024.
//

import Foundation
import Combine

class PropertyViewModel : ObservableObject {
    
    @Published var properties : [Property] = []
    
    init() {
        loadProperties()
    }
    
    func loadProperties() {
        properties = [
            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Apartment, price: 123123, location: "Tagmo3", numberOfBedrooms: 2, numberOfBathrooms: 3, size: 125, imageURL: "1"),
            
            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Villa, price: 24432, location: "Tagmo3", numberOfBedrooms: 1, numberOfBathrooms: 2, size: 148, imageURL: "2"),
            
            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .House, price: 554332, location: "Fesal", numberOfBedrooms: 3, numberOfBathrooms: 2, size: 100, imageURL: "3"),
            
            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Villa, price: 433355, location: "helmya", numberOfBedrooms: 2, numberOfBathrooms: 3, size: 123, imageURL: "4"),
            
            Property(id: UUID(), name: "Youssef alaa", description: "Rumah pakuwon city is located in Surabaya City which is not far from the city center. This house was made in 2010 with a minimalist and modern architecture suitable for families", type: .Apartment, price: 553221, location: "Tagmo3", numberOfBedrooms: 3, numberOfBathrooms: 1, size: 255, imageURL: "2")
        ]
        
    }
    
    func filterProperties(by type: Property.PropertyType) -> [Property] {
        
        if type == .All {
            return properties
        } else {
            return properties.filter { $0.type == type }
        }
    }
}
