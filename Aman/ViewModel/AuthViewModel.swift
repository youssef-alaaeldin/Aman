//
//  AuthViewModel.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 13/08/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Combine

enum ValidateState {
    case valid
    case invalid(String)
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    @Published var email = ""
    @Published var password = ""
    @Published var emailValidation : ValidateState = .valid
    @Published var passwordValidation : ValidateState = .valid
    @Published var isFormValid = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
        
        setupValidation()
    }
    
    private func setupValidation() {
        $email
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { self.validateEmail($0) }
            .assign(to: &$emailValidation)
//            .store(in: &cancellables)
        
        $password
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { self.validatePassword($0) }
            .assign(to: &$passwordValidation)
//            .store(in: &cancellables)
        
        Publishers.CombineLatest($emailValidation, $passwordValidation)
            .map { emailValidation, passwordValidation in
                if case .valid = emailValidation, case .valid = passwordValidation {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
    
    func updateUsername(newUsername: String) async {
            guard let currentUser = self.currentUser else { return }
            let userId = currentUser.id ?? ""
            do {
                try await Firestore.firestore().collection("users").document(userId).updateData(["fullName": newUsername])
                self.currentUser?.fullName = newUsername
            } catch {
                print("Failed to update username: \(error.localizedDescription)")
            }
        }
    
    func validateEmail(_ email: String) -> ValidateState {
        if email.isEmpty {
            return .invalid("Email Cannot be empty")
        } else if !email.contains("@") {
            return .invalid("Invalid email format")
        }
        return .valid
    }
    
    func validatePassword(_ password: String) -> ValidateState {
        if password.isEmpty {
            return .invalid("Password cannot be empty")
        } else if password.count < 6 {
            return .invalid("Password must be at least 6 characters ")
        }
        return .valid
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            throw error
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email, role: "Regular")
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id ?? "").setData(encodedUser)
            await fetchUser()
        } catch {
            throw error
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.userSession = nil
        } catch {
            print("Error while signing out with \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
    }
}

