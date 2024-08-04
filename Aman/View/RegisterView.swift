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
    @State var isChecked = false
    var body: some View {
        NavigationStack {
            
            VStack (spacing: 16) {
                
                textFields
                
                HStack {
                    CustomCheckBox(isChecked: $isChecked)
                    HStack(spacing: 5) {
                        Text("I agree with")
                        Text("Term of Conditions")
                            .foregroundStyle(Colors.Primary.p500)
                        Text("and")
                        Text("Privacy Policy")
                            .foregroundStyle(Colors.Primary.p500)
                    }
                    .font(FontStyles.Body.mediumRegular)
                }
                CustomButton(label: "Register")
                
            }
            .navigationTitle(isSignUp ? "Sign Up" : "Let's Login")
            .padding()
        }
        
        
    }
    
    var textFields: some View {
        Group {
            CustomTextField(textValue: $fullName, placeHolder: "Enter full name", keyboardType: .default, title: "Full Name")
            
            CustomTextField(textValue: $email, placeHolder: "Enter email", keyboardType: .emailAddress, title: "Email")
            
            CustomTextField(textValue: $password, isPasswordField: true, placeHolder: "Enter password", keyboardType: .default, title: "Password")
        }
    }
}

#Preview {
    RegisterView()
}
