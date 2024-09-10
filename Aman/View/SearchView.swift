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
    @EnvironmentObject private var viewModel: PropertyViewModel
    @State private var recentSearchItems = [String]()
    
    @State private var showSearchedProperties = false
    
    private let columns = [GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 10)]
    
    var body: some View {
        
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
                            if !searchText.isEmpty {
                                if !recentSearchItems.contains(searchText) {
                                    recentSearchItems.append(searchText)
                                    saveRecentSearch()
                                }
                                viewModel.searchProperty(by: searchText)
                                showSearchedProperties = true
                            }
                            print("submit")
                        }
                        .onTapGesture {
                            showSearchedProperties = false 
                            
                        }
                }
                Divider()
                    .padding(.horizontal, -10)
                
                ScrollView {
                    
                    if isSearchViewFieldFocus {
                        recentSearch
                        
                    }
                    
                    if showSearchedProperties && !searchText.isEmpty {
                        if !viewModel.searchedProperties.filter({ $0.description.localizedStandardContains(searchText)}).isEmpty {
                            propertiesList
                        } else {
                            
                            notFoundProperty
                        }
                    }
                }
//                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden()
            .onAppear {
                if searchText.isEmpty {
                showSearchedProperties = false
                } else {
                    showSearchedProperties = true
                    isSearchViewFieldFocus = false
                }
                print("Filtered Properties: \(viewModel.searchedProperties.count)")
                
                loadRecentSearch()
            }
            .onDisappear {
                print("Disappear")
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
                    saveRecentSearch()
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
                        saveRecentSearch()
                    }
                    .onTapGesture {
                        searchText = search
                        viewModel.searchProperty(by: search)
                        isSearchViewFieldFocus = false
                        showSearchedProperties = true
                    }
                }
            }
        }
        .padding(.vertical)
    }
    
    private var propertiesList: some View {
        VStack(alignment: .leading) {
            
            Button {
                coordinator.present(sheet: .filters)
            } label: {
                HStack {
                    Text("Filter")
                    Image("Filter")
                }
                .foregroundStyle(Colors.Neutrals.n900)
                .font(FontStyles.Body.smallRegular)
            }
            .frame(width: 79, height: 33)
            .background(Colors.Neutrals.n50)
            .clipShape(.rect(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Colors.Neutrals.n200, lineWidth: 1)
            )
            
            
            Text("\(viewModel.searchedProperties.filter { $0.description.localizedStandardContains(searchText)}.count) ads found")
                .foregroundStyle(Colors.Neutrals.n900)
                .font(FontStyles.Body.largeBold)
            
            ForEach(viewModel.searchedProperties.filter { $0.description.localizedStandardContains(searchText)}, id: \.id) { prop in
                    
                    FavoriteCardView(property: prop)
                    
                }
            
        }
    }
    
    var notFoundProperty: some View {
        Group {
            Text("Not Found")
                .foregroundStyle(Colors.Neutrals.n900)
                .font(FontStyles.Heading.h4)
            
            Text("No results from \(searchText), try with other keywords")
                .foregroundStyle(Colors.Neutrals.n600)
                .multilineTextAlignment(.center)
            
        }
        
    }
    
    //MARK: - User Defaults
    
    private func loadRecentSearch() {
        
        if let items = UserDefaults.standard.array(forKey: Constants.RecentSearches.recentSearchItemKey) as? [String] {
            recentSearchItems = items
        }
        
        print(recentSearchItems)
       
    }
    
    private func saveRecentSearch() {
        UserDefaults.standard.set(recentSearchItems, forKey: Constants.RecentSearches.recentSearchItemKey)
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
