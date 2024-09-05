//
//  CustomStepper.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 04/09/2024.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value : Int
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(FontStyles.Body.mediumRegular)
                .foregroundStyle(Colors.Neutrals.n600)
            Spacer()
            
            HStack {
                Button {
                    if value > 2 {
                        value -= 1
                        
                    }
                } label: {
                    Image(systemName: "minus.circle")
                }
                
                Text("\(value)")
                
                Button {
                    if value < 10 {
                        value += 1
                        
                    }
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
        }
    }
}

//#Preview {
//    CustomStepper()
//}
