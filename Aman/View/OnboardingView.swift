//
//  ContentView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 03/08/2024.
//

import SwiftUI

struct OnboardingStep {
    let image: String
    let title: String
    let description: String
}

private let onboardingSteps = [
    OnboardingStep(image: "1", title: "#1 Best Real Estate App in The World", description: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."),
    
    OnboardingStep(image: "2", title: "There Are Various Types of Houses are Here", description: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."),
    
    OnboardingStep(image: "3", title: "Find Your Dream House Easily And Quickly", description: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.")
    
]

struct OnboardingView: View {
    
    
    @State private var currentStep = 0
    
    @EnvironmentObject private var coordinator : Coordinator
    
//    init() {
//        UIScrollView.appearance().bounces = false
//    }
    
    var body: some View {
        
        TabView(selection : $currentStep) {
            ForEach(0..<onboardingSteps.count, id: \.self) { item in
                bodyText(item: onboardingSteps[item])
                    .tag(item)
            }
           
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .padding()
        
        slideView
    }
    
    struct bodyText: View {
        
        var item: OnboardingStep
        var body: some View {
            VStack(alignment: .center, spacing: 16) {
                
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 266, height: 350)
                    .clipShape(.rect(topLeadingRadius: 400, topTrailingRadius: 400))
                
                
                Text(item.title)
                    .font(FontStyles.Heading.h3)
                    .foregroundStyle(Colors.Neutrals.n900)
                    .multilineTextAlignment(.center)
                
                
                Text(item.description)
                    .font(FontStyles.Body.mediumRegular)
                    .foregroundStyle(Colors.Neutrals.n600)
                    .multilineTextAlignment(.center)
            }
            .padding()
            
        }
    }
    
    
    var slideView : some View {
        
        VStack(spacing: 40) {
            HStack {
                ForEach(0..<onboardingSteps.count , id: \.self) { index in
                    Rectangle()
                        .clipShape(.rect(cornerRadius: 20))
                        .foregroundStyle(currentStep == index ? Colors.Primary.p500 : .smallCircle)
                        .frame(width: currentStep == index ? 27 : 8 , height: 8)
                        .animation(.easeInOut, value: currentStep)
                    
                }
            }
            .padding(.bottom , 10)
            
            
            CustomButton(label: currentStep < onboardingSteps.count - 1 ? "Next" : "Get Started") {
                if self.currentStep < onboardingSteps.count - 1 {
                    withAnimation {
                        currentStep += 1
                    }
                }
                else {
                    coordinator.push(.register)
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
