//
//  ContentView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 03/08/2024.
//

import SwiftUI

struct OnboardingView: View {
    
    let elements = ["#1 Best Real Estate App in The World",
                    "There Are Various Types of Houses are Here",
                    "Find Your Dream House Easily And Quickly"]
    
    @State private var currentText = 0
    @State private var goToLogin = 1
    
    @EnvironmentObject var coordinator : Coordinator
    
    var body: some View {
        
        VStack {
            
            Image(String(currentText + 1))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 266, height: 350)
                .clipShape(.rect(topLeadingRadius: 400, topTrailingRadius: 400))
            bodyText
            
            slideView
        }
    }
    
    var bodyText: some View {
        VStack(alignment: .center, spacing: 16) {
            Text(elements[currentText])
                .font(FontStyles.Heading.h3)
                .foregroundStyle(Colors.Neutrals.n900)
                .multilineTextAlignment(.center)
            
            
            Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.")
                .font(FontStyles.Body.mediumRegular)
                .foregroundStyle(Colors.Neutrals.n600)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
    var slideView : some View {
        
        VStack(spacing: 40) {
            HStack {
                ForEach(0..<elements.count , id: \.self) { index in
                    Rectangle()
                        .clipShape(.rect(cornerRadius: 20))
                        .foregroundStyle(currentText == index ? Colors.Primary.p500 : .smallCircle)
                        .frame(width: currentText == index ? 27 : 8 , height: 8)
                    
                }
            }
            
            if currentText == elements.count - 1 {
                
                CustomButton(label: "Get Started") {
//                    coordinator.pu(fullScreenCover: .register)
                    coordinator.push(.register)
                }
            }
            else {
                CustomButton(label: "Next") {
                    withAnimation {
                        if currentText < elements.count - 1 {
                            currentText += 1
                        }
                    }
                }
                
            }
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
