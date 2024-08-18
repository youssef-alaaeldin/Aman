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
    var body: some View {
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
            } else {
                Text("No user information")
                    .font(FontStyles.Body.largeRegular)
                    .foregroundStyle(Colors.Neutrals.n900)
            }
            
//            Spacer()
        }
    }
}

#Preview {
    AccountView()
}
