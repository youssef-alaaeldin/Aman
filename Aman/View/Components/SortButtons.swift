//
//  SortButtons.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 04/09/2024.
//

import SwiftUI

enum SortOptions: String, CaseIterable {
   
    case Newest
    case HighestPrice
    case LoestPrice
    case None
}

struct SortButtons: View {
    @Binding var selectedChoice: SortOptions
    var body: some View {
        VStack {
            HStack {
                ForEach(SortOptions.allCases.filter { $0.rawValue != "None"}, id: \.rawValue) { choice in
                    Button {
                        withAnimation {
                            selectedChoice = choice
                        }
                    } label: {
                        Text(choice.rawValue)
                            .foregroundStyle(selectedChoice == choice ? Colors.Neutrals.n50 : Colors.Neutrals.n900)
                            .font(FontStyles.Body.smallRegular)
                            .padding()
                        
                    }
                    .frame(height: 32)
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
    SortButtons(selectedChoice: .constant(.Newest))
}
