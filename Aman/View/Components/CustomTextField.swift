//
//  CustomTextField.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 03/08/2024.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var textValue: String
    @State private var isPasswordVisible = true
    @State var isPasswordField = false
    @Binding var showWarnings : Bool
    var placeHolder: String = ""
    var keyboardType: UIKeyboardType
    var title: String
    
    init(textValue: Binding<String>,
         isPasswordField: Bool = false,
         showWarnings: Binding<Bool> = .constant(false),
         placeHolder: String = "",
         keyboardType: UIKeyboardType = .default,
         title: String) {
        self._textValue = textValue
        self._showWarnings = showWarnings
        self.isPasswordField = isPasswordField
        self.placeHolder = placeHolder
        self.keyboardType = keyboardType
        self.title = title
    }
   
    var body: some View {
        
        VStack (alignment: .leading) {
            Text(title)
                .font(FontStyles.Body.mediumRegular)
                .foregroundStyle(Colors.Neutrals.n900)
            
            if isPasswordField {
                HStack {
                    if isPasswordVisible {
                        SecureField(text: $textValue) {
                            Text(placeHolder)
                                .font(FontStyles.Body.mediumRegular)
                                .foregroundStyle(Colors.Neutrals.n600)
                        }
                    } else {
                        TextField(text: $textValue) {
                            Text(placeHolder)
                                .font(FontStyles.Body.mediumRegular)
                                .foregroundStyle(Colors.Neutrals.n600)
                        }
                    }
                    
                }
                .padding()
                .background(Colors.Neutrals.n100)
                .clipShape(.rect(cornerRadius: 8))
                .keyboardType(keyboardType)
                .overlay(alignment: .trailing) {
                    Image(systemName: isPasswordVisible ?  "eye.slash" : "eye")
                        .onTapGesture {
                            isPasswordVisible.toggle()
                        }
                        .padding()
                }
            } else {
                TextField(text: $textValue) {
                    Text(placeHolder)
                        .font(FontStyles.Body.mediumRegular)
                        .foregroundStyle(Colors.Neutrals.n600)
                }
                .padding()
                .background(Colors.Neutrals.n100)
                .clipShape(.rect(cornerRadius: 8))
                .keyboardType(keyboardType)
                .onChange(of: textValue) {
                    showWarnings = true
                }
                
            }
            
        }
//        .padding()
        .textInputAutocapitalization(.never)
    }
}

//#Preview {
//    CustomTextField(textValue: .constant(""), keyboardType: .default)
//}
