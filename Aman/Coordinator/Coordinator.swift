//
//  Coordinator.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 05/08/2024.
//

import SwiftUI


enum Page: String, Identifiable {
    
    case onboarding, register, explore
    
    var id: String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    
    case onboarding, register
    
    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {

    case register , explore
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    // SHEET PRESENTING
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    // FULLSCREEN COVER PRESENTING
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .onboarding:
            OnboardingView()
        case .explore:
            ExploreView()
        case .register:
            RegisterView()
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .onboarding:
            OnboardingView()
        case .register:
            RegisterView()
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .explore:
            ExploreView()
        case .register:
            RegisterView()
        }
    }
}

