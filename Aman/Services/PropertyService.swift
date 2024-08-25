////
////  PropertyService.swift
////  Aman
////
////  Created by Yousuf Abdelfattah on 14/08/2024.
////
//
//import Foundation
//import FirebaseFirestore
//import FirebaseAuth
//
//class PropertyService {
//    
//    private var db = Firestore.firestore()
//    
//    func addProperty(_ property: Property, completion: @escaping (Result<Void,Error>) -> Void) {
//        do {
//            let _ = try db.collection("properties").addDocument(from: property) { error in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(()))
//                }
//            }
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//    
//    func fetchProperties(completion: @escaping (Result<[Property],Error>) -> Void) {
//        db.collection("properties").getDocuments { snapshot, error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                let properties = snapshot?.documents.compactMap { document in
//                    try? document.data(as: Property.self)
//                    
//                } ?? []
//                
//                completion(.success(properties))
//            }
//        }
//    }
//    
//    func addSampleData(name: String, description: String, type: Property.PropertyType, price: Double, location: String, numberOfBedrooms: Int, numberOfBathrooms: Int, size: Double, images: [UIImage]) {
//            let sampleProperty =
//                Property(id: nil, name: name, description: description, type: type, price: price, location: location, numberOfBedrooms: numberOfBedrooms, numberOfBathrooms: numberOfBathrooms, size: 120, images: images)
//            
//                addProperty(sampleProperty) { result in
//                    switch result {
//                    case .success:
//                        print("Property added: \(sampleProperty.name)")
//                    case .failure(let error):
//                        print("Error adding property: \(error)")
//                    }
//                }
//            
//        }
//}


import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class PropertyService {
    
    private var db = Firestore.firestore()
    
    // Function to add a property to Firebase Firestore
    func addProperty(_ property: Property, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            // Try to encode the Property object and add it to the "properties" collection
            let _ = try db.collection("properties").addDocument(from: property) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    // Function to fetch properties from Firebase Firestore
    func fetchProperties(completion: @escaping (Result<[Property], Error>) -> Void) {
        db.collection("properties").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                // Map the documents to Property objects
                let properties = snapshot?.documents.compactMap { document in
                    try? document.data(as: Property.self)
                } ?? []
                
                completion(.success(properties))
            }
        }
    }
    
    // Function to add sample data for testing purposes
    func addSampleData(
        name: String,
        description: String,
        type: Property.PropertyType,
        price: Double,
        location: String,
        numberOfBedrooms: Int,
        numberOfBathrooms: Int,
        size: Double,
        images: [String]
    ) {
        // Create a Property object with the provided details
        let sampleProperty = Property(
            id: nil,
            name: name,
            description: description,
            type: type,
            price: price,
            location: location,
            numberOfBedrooms: numberOfBedrooms,
            numberOfBathrooms: numberOfBathrooms,
            size: size,
            imageUrls: images
        )
        
        // Add the sample property using the addProperty function
        addProperty(sampleProperty) { result in
            switch result {
            case .success:
                print("Property added: \(sampleProperty.name)")
            case .failure(let error):
                print("Error adding property: \(error)")
            }
        }
    }
}

