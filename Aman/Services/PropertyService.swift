//
//  PropertyService.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 14/08/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class PropertyService {
    
    private var db = Firestore.firestore()
    
    func addProperty(_ property: Property, completion: @escaping (Result<Void,Error>) -> Void) {
        do {
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
    
    func fetchProperties(completion: @escaping (Result<[Property],Error>) -> Void) {
        db.collection("properties").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let properties = snapshot?.documents.compactMap { document in
                    try? document.data(as: Property.self)
                    
                } ?? []
                
                completion(.success(properties))
            }
        }
    }
    
    func addSampleData() {
            let sampleProperties = [
                Property(id: nil, name: "Cozy Cottage", description: "A cozy cottage in the woods.", type: .House, price: 250000, location: "Lake District", numberOfBedrooms: 3, numberOfBathrooms: 2, size: 120, images: ["3", "2" , "4", "1"]),
                Property(id: nil, name: "Modern Apartment", description: "A modern apartment in the city center.", type: .Apartment, price: 350000, location: "New York", numberOfBedrooms: 2, numberOfBathrooms: 1, size: 85, images: ["4", "3" , "2", "1"]),
                Property(id: nil, name: "Luxury Villa", description: "A luxury villa with a private pool.", type: .Villa, price: 1500000, location: "Beverly Hills", numberOfBedrooms: 5, numberOfBathrooms: 4, size: 450, images: ["1", "2" , "3", "4"]),
            ]
            
            for property in sampleProperties {
                addProperty(property) { result in
                    switch result {
                    case .success:
                        print("Property added: \(property.name)")
                    case .failure(let error):
                        print("Error adding property: \(error)")
                    }
                }
            }
        }
}
