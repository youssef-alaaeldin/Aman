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
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var authViewModel : AuthViewModel
    
    @State private var signingUp = false
    @State private var loggingIn = false
    
    @State private var showWarningsEmail = false
    @State private var showWarningsPassword = false
    private let accountsImages = ["google", "facebook", "apple"]
    
    var body: some View {
        
        ScrollView {
            VStack (spacing: 16) {
                
                textFields
                if isSignUp {
                    policyAgreementForSignup
                } else {
                    forgetPassword
                }
                
                if signingUp || loggingIn {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                else {
                    registerButton
                }
                
                if isSignUp {
                    signUpPart
                } else {
                    loginPart
                }
                
                HStack {
                    Text(isSignUp ? "Already have an account?" : "Don't have an account?")
                    Button {
                        withAnimation {
                            isSignUp.toggle()
                            reset()
                        }
                        if !isSignUp {
                            isChecked = true
                        }
                    } label: {
                        Text(isSignUp ? "Login" : "Sign Up")
                    }
                }
                
                Spacer()
            }
            .navigationTitle(isSignUp ? "Sign Up" : "Let's Login")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden()
            .padding()
        }
        
    }
    
    
    // MARK: - SubViews
    
    var loginPart: some View {
        Group {
            HStack(spacing: 16){
                Rectangle()
                    .frame(width: 110, height: 1)
                    .foregroundStyle(Colors.Neutrals.n200)
                
                Text("Or Login With")
                    .font(FontStyles.Body.smallRegular)
                    .foregroundStyle(Colors.Neutrals.n900)
                
                Rectangle()
                    .frame(width: 110, height: 1)
                    .foregroundStyle(Colors.Neutrals.n200)
                
            }
            
            ForEach(accountsImages, id: \.self) { account in
                
                Button {
                    
                } label: {
                    Image(account)
                }
                .frame(width: 343, height: 48)
                .background(Colors.Neutrals.n50)
                .clipShape(.rect(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Colors.Neutrals.n200, lineWidth: 1)
                )
                
            }
        }
    }
    
    var forgetPassword: some View {
        HStack {
            Spacer()
            Button {
                //TODO: FORGOT PASSWORD
            } label: {
                Text("Forgot Password?")
            }
            
        }
    }
    
    var policyAgreementForSignup: some View {
        HStack(spacing: 15) {
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
    }
    
    var signUpPart: some View {
        HStack (spacing: 36) {
            
            ForEach(accountsImages, id: \.self) { account in
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Colors.Neutrals.n50)
                    .overlay (alignment: .center) {
                        Circle()
                            .stroke(Colors.Neutrals.n200,lineWidth: 1)
                        Image(account)
                    }
            }
            
        }
    }
    
    var textFields: some View {
        VStack(alignment: .leading,spacing: 16) {
            
            if isSignUp {
                CustomTextField(textValue: $fullName, placeHolder: "Enter full name", keyboardType: .default, title: "Full Name")
            }
            
            
            CustomTextField(textValue: $authViewModel.email ,placeHolder: "Enter email", keyboardType: .emailAddress, title: "Email")
                .onChange(of: authViewModel.email) { _, _ in
                    showWarningsEmail = true
                }
            
            if showWarningsEmail {
                if case .invalid(let message) = authViewModel.emailValidation {
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                        Text(message)
                    }
                    .foregroundStyle(Colors.Other.validationColor)
                }
            }
            
            
            CustomTextField(textValue: $authViewModel.password, isPasswordField: true , placeHolder: "Enter password", keyboardType: .default, title: "Password")
                .onChange(of: authViewModel.password) { _, _ in
                    showWarningsPassword = true 
                }
            
            if showWarningsPassword {
                if case .invalid(let message) = authViewModel.passwordValidation {
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                        Text(message)
                    }
                    .foregroundStyle(Colors.Other.validationColor)
                }
            }
            
        }
    }
    
    var registerButton : some View {
        
        CustomButton(label: isSignUp ? "Register" : "Login", action: {
            if isSignUp {
                signUpUser()
            } else {
                signInUser()
                
            }
        })
        .opacity(isChecked && authViewModel.isFormValid ? 1.0 : 0.5)
        .disabled(!isChecked && !authViewModel.isFormValid)
    }
    
    //MARK: - Actions
    
    private func signUpUser() {
        Task {
            signingUp = true
            do  {
                try await authViewModel.createUser(withEmail: authViewModel.email, password: authViewModel.password, fullName: fullName)
                self.coordinator.push(.main)
                reset()
            } catch {
//                showWarnings = true
                print("Error creating user \(error.localizedDescription)")
            }
            signingUp = false
        }
        
    }
    
    private func signInUser() {
        
        Task {
            loggingIn = true
            do {
                try await authViewModel.signIn(withEmail: authViewModel.email, password: authViewModel.password)
                
                self.coordinator.push(.main)
                reset()
            } catch {
//                showWarnings = true
                print("Error loging in \(error.localizedDescription)")
            }
            loggingIn = false
        }
    }
    
    func reset() {
        fullName = ""
        authViewModel.email = ""
        authViewModel.password = ""
        isChecked = false
        showWarningsEmail = false
        showWarningsPassword = false
        
    }
}

#Preview {
    RegisterView()
}
