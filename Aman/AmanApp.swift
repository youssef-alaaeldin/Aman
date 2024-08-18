//
//  AmanApp.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 03/08/2024.
//

import SwiftUI
import Firebase

@main
struct AmanApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var propertyViewModel = PropertyViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environmentObject(authViewModel)
                .environmentObject(propertyViewModel)
                
        }
    }
}
