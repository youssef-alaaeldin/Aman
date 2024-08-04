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
    
    private let accountsImages = ["google", "facebook", "apple"]
    
    var body: some View {
        
        NavigationStack {
            VStack (spacing: 16) {
                
                textFields
                if isSignUp {
                     policyAgreementForSignup
                } else {
                    forgetPassword
                }
                
               
                CustomButton(label: isSignUp ? "Register" : "Login", action: {
                    //TODO: SIGN UP
                })
                    .opacity(isChecked ? 1.0 : 0.5)
                    .disabled(!isChecked)
                
                signUpPart
                
                HStack {
                    Text("Already have an account?")
                    Button {
                        withAnimation {
                            isSignUp = false
                        }
                    } label: {
                        Text("Login")
                    }
                }
                
                Spacer()
            }
            .navigationTitle(isSignUp ? "Sign Up" : "Let's Login")
            .padding()
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
        Group {
            
            if isSignUp {
                CustomTextField(textValue: $fullName, placeHolder: "Enter full name", keyboardType: .default, title: "Full Name")
            }
                
                CustomTextField(textValue: $email, placeHolder: "Enter email", keyboardType: .emailAddress, title: "Email")
                
                CustomTextField(textValue: $password, isPasswordField: true, placeHolder: "Enter password", keyboardType: .default, title: "Password")
            
        }
    }
}

#Preview {
    RegisterView()
}
