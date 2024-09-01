//
//  SearchView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 01/09/2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText : String = ""
    @FocusState private var isSearchViewFieldFocus: Bool
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var recentSearchItems = [String]()
    
    private let columns = [GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 10)]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack(spacing: 0) {
                    Button {
                        coordinator.pop()
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                    .buttonStyle(.plain)
                    
                    SearchBar(searchValue: $searchText, title: "Search")
                        .focused($isSearchViewFieldFocus)
                        .onAppear {
                            isSearchViewFieldFocus = true
                        }
                        .onSubmit {
                            recentSearchItems.append(searchText)
                            searchText = ""
                        }
                }
                Divider()
                    .padding(.horizontal, -10)
                
                recentSearch
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden()
        }
    }
    
    private var recentSearch: some View {
        VStack {
            HStack {
                
                Text("Recent Search")
                    .foregroundStyle(Colors.Neutrals.n900)
                    .font(FontStyles.Body.largeBold)
                Spacer()
                Button {
                    //CLEAR THE ARRAY
                    recentSearchItems.removeAll()
                } label: {
                    Text("Clear All")
                        .foregroundStyle(Colors.Neutrals.n600)
                        .font(FontStyles.Body.mediumRegular)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(recentSearchItems, id: \.self) {
                    search in
                    SearchTagView(search: search) {
                        recentSearchItems.removeAll { $0 == search}
                    }
                }
            }
        }
        .padding(.vertical)
    }
    
    struct SearchTagView: View {
        let search: String
        var onRemove: () -> Void
        
        var body: some View {
            HStack {
                Text(search)
                    .font(.subheadline)
                    .foregroundStyle(Colors.Neutrals.n600)
                    .padding(.leading, 10)
                
                Button(action: onRemove) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .padding(.trailing, 10)
                        .foregroundStyle(Colors.Neutrals.n600)
                }
            }
            .padding(.vertical, 8)
            .background(Colors.Neutrals.n100)
            .cornerRadius(8)
        }
    }
}

#Preview {
    SearchView()
}
