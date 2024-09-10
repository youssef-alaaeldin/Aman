//
//  User.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 13/08/2024.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var fullName: String
    let email: String
    let role: String
    var favoritePropertyIDs: [String] = []
    
}


extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Joe", email: "test@gmail.com", role: "Regular")
}

