//
//  FirebaseService.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 15/08/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

final class FirebaseService {
    static let shared = FirebaseService()
    let db = Firestore.firestore()

    private init() {
        FirebaseApp.configure()
    }
}
