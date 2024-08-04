//
//  CustomButton.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 04/08/2024.
//

import SwiftUI

struct CustomButton: View {
    
    var label: String
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .font(FontStyles.Body.mediumBold)
                .foregroundStyle(Colors.Neutrals.n50)
        }
        .frame(width: 343, height: 52)
        .background(Colors.Primary.p500)
        .clipShape(.rect(cornerRadius: 8))
    }
}

//#Preview {
//    CustomButton(label: "Next")
//}
