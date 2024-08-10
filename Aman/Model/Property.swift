//
//  Property.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 07/08/2024.
//

import Foundation

struct Property: Identifiable {
    
    let id: UUID
    let name: String
    let type: PropertyType
    let price: Double
    let location: String
    let numberOfBedrooms: Int
    let numberOfBathrooms: Int
    let size: Double // in square meters
    let imageURL: String
    
    enum PropertyType: String, CaseIterable {
        case All
        case House
        case Villa
        case Apartment
    }
}
