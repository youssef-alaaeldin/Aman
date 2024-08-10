//
//  TopNavBar.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 08/08/2024.
//

import SwiftUI

struct TopNavBar: View {
    
    var action : () -> Void
    var body: some View {
        ZStack {
            HStack {
                Button {
                    action()
                } label: {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                        .overlay (alignment: .center) {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .frame(width: 20, height: 15)
                                .foregroundStyle(Colors.Neutrals.n900)
                        }
                    
                }
                Spacer()
                Button {
                    
                } label: {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                        .overlay (alignment: .center) {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .foregroundStyle(Colors.Neutrals.n900)
                                .frame(width: 20, height: 20)
                        }
                    
                }
                
            }
            .padding()
        }
        .frame(height: 56)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
//
//#Preview {
//    TopNavBar()
//}
