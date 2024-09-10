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
    var imageUrls: [String] = [] // Stores the URLs of the images
    let date: Date
    enum PropertyType: String, CaseIterable, Codable {
        case All
        case House
        case Villa
        case Apartment
    }
    
    // Computed property for handling image URLs if needed
//    var images: [UIImage] = []
}
