//
//  RegisterView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 03/08/2024.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var isSignUp = true
    @State var email = ""
    @State var fullName = ""
    @State var password = ""
    var body: some View {
        NavigationStack {
            
            VStack (spacing: 16) {
                CustomTextField(textValue: $fullName, placeHolder: "Enter full name", keyboardType: .default, title: "Full Name")
                
                CustomTextField(textValue: $email, placeHolder: "Enter email", keyboardType: .emailAddress, title: "Email")
                
                CustomTextField(textValue: $password, isPasswordField: true, placeHolder: "Enter password", keyboardType: .default, title: "Password")
            }
            .navigationTitle(isSignUp ? "Sign Up" : "Let's Login")
            .padding()
        }
        
        
    }
}

#Preview {
    RegisterView()
}
