//
//  AccountView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI

struct AccountView: View {
    
    let user = User.MOCK_USER
    @EnvironmentObject private var auth: AuthViewModel
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                if let currentUser = auth.currentUser {
                    Image("profile-pic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    
                    VStack {
                        Text(currentUser.fullName)
                            .font(FontStyles.Heading.h4)
                            .foregroundStyle(Colors.Neutrals.n900)
                        
                        Text("Cairo, Egypt")
                            .font(FontStyles.Body.mediumRegular)
                            .foregroundStyle(Colors.Neutrals.n600)
                        
                        Button("Sign out") {
                            Task {
                                auth.signOut()
                                coordinator.popToRoot()
                            }
                        }
                    }
                    
                    CustomTextField(textValue: $fullName, isPasswordField: false, placeHolder: "\(currentUser.fullName)", keyboardType: .default, title: "Full Name")
                    
                    CustomTextField(textValue: $email, isPasswordField: false, placeHolder: "\(currentUser.email)", keyboardType: .default, title: "Email")
                    
                    CustomTextField(textValue: $password, isPasswordField: true, placeHolder: "Enter new password", keyboardType: .default, title: "Password")
                    
                    Spacer()
                    
                    CustomButton(label: "Save Change") {
                        Task {
                            await saveChanges()
                            print("Success \(currentUser.fullName)")
                        }
                    }
                
                } else {
                    Text("No user information")
                        .font(FontStyles.Body.largeRegular)
                        .foregroundStyle(Colors.Neutrals.n900)
                }
                
                //            Spacer()
            }
            .padding()
            .onAppear {
                self.fullName = auth.currentUser?.fullName ?? ""
                self.email = auth.currentUser?.email ?? ""
            
            }
        }
          
    }
    
    private func saveChanges() async {
           if fullName != auth.currentUser?.fullName {
               await updateUsername()
           }
           
//           if email != auth.currentUser?.email {
//               await updateEmail()
//           }
//           
//           if !password.isEmpty {
//               await updatePassword()
//           }
       }
       
       // Function to update the username
       private func updateUsername() async {
           do {
               await auth.updateUsername(newUsername: fullName)
           }
       }
}

#Preview {
    AccountView()
}
