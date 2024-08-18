//
//  Property.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 07/08/2024.
//

import Foundation
import FirebaseFirestore
struct Property: Identifiable, Codable {
    
    @DocumentID var id: String?
    let name: String
    let description: String
    let type: PropertyType
    let price: Double
    let location: String
    let numberOfBedrooms: Int
    let numberOfBathrooms: Int
    let size: Double // in square meters
    let images: [String]
    
    enum PropertyType: String, CaseIterable, Codable {
        case All
        case House
        case Villa
        case Apartment
    }
}
