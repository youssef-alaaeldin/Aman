//
//  TopNavBar.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 08/08/2024.
//

import SwiftUI

struct TopNavBar: View {
    
    var backAction : () -> Void
    var deleteAction: () -> Void
    var showDeleteDialog: () -> Void
    @Binding var showDeleteConfirmation: Bool
    var body: some View {
        ZStack {
            HStack {
                Button {
                    backAction()
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
                    showDeleteDialog()
                } label: {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                        .overlay (alignment: .center) {
                            Image(systemName: "trash")
//                                .resizable()
                                .foregroundStyle(.red)
//                                .frame(width: 20, height: 20)
                        }
                    
                }
                .buttonStyle(PlainButtonStyle())
                .confirmationDialog("Are you sure you want to delete this property?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
                        Button("Delete", role: .destructive) {
                            deleteAction()  // Perform delete action
                        }
                    Button("Cancel", role: .cancel) {
                        // Cancel action (no need for additional code)
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
