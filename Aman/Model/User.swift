//
//  User.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 13/08/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    
    
    
}


extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Joe", email: "test@gmail.com")
}

