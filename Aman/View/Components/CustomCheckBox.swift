//
//  CustomCheckBox.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 03/08/2024.
//

import SwiftUI

struct CustomCheckBox: View {
    
    @Binding var isChecked : Bool
    var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    CustomCheckBox(isChecked:.constant(true))
}
