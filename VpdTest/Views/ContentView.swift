//
//  ContentView.swift
//  VpdTest
//
//  Created by DevSampel on 20/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RepositoriesViewModel()
    @State private var showError = false
    @State private var searchText = ""
    
    var filteredRepositories: [Repository] {
        if searchText.isEmpty {
            return viewModel.repositories
        } else {
            return viewModel.repositories.filter { repository in
                repository.name.localizedCaseInsensitiveContains(searchText) ||
                repository.fullName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomSearchBar(text: $searchText, placeholder: "Search repositories")
                    .padding(.vertical, 8)

                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(filteredRepositories) { repository in
                            NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                                RepositoryRowView(repository: repository)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .onAppear {
                                if repository.id == viewModel.repositories.last?.id {
                                    viewModel.loadMore()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    }
                }
                .refreshable {
                    viewModel.refresh()
                }
                .navigationTitle("GitHub Repositories")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(
                    Color("buttoncolor"),
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .alert(isPresented: $showError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage ?? "Unknown error occurred"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .onChange(of: viewModel.errorMessage) { oldValue, newValue in
                    showError = newValue != nil
                }
            }
        }
        .onAppear {
            if viewModel.repositories.isEmpty {
                viewModel.fetchRepositories()
            }
        }
    }
}

#Preview {
    ContentView()
}
