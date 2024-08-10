//
//  FilterButtonsView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 06/08/2024.
//

import SwiftUI


struct FilterButtonsView: View {
    
    @Binding var selectedChoice: Property.PropertyType
    var body: some View {
        VStack {
            HStack {
                ForEach(Property.PropertyType.allCases, id: \.rawValue) { choice in
                    Button {
                        withAnimation {
                            selectedChoice = choice
                        }
                    } label: {
                        Text(choice.rawValue)
                            .foregroundStyle(selectedChoice == choice ? Colors.Neutrals.n50 : Colors.Neutrals.n900)
                            .padding()
                        
                    }
                    .frame(height: 42)
                    .background(selectedChoice == choice ? Colors.Primary.p500 : Colors.Neutrals.n50)
                    .clipShape(.rect(cornerRadius: 50))
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Colors.Neutrals.n200, lineWidth: 1)
                    )
                    
                }
            }
        }
    }
}

#Preview {
    FilterButtonsView(selectedChoice: .constant(.All))
}
