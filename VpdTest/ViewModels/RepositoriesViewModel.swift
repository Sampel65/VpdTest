
//
//  RepositoriesViewModel.swift
//  VpdTest
//
//  Created by DevSampel on 20/03/2025.
//

import Foundation

class RepositoriesViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var currentPage = 0
    
    func fetchRepositories(isRefreshing: Bool = false) {
        if isRefreshing {
            currentPage = 0
        }
        
        isLoading = true
        errorMessage = nil
        
        NetworkService.shared.fetchRepositories(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let newRepositories):
                    if isRefreshing {
                        self?.repositories = newRepositories
                    } else {
                        self?.repositories.append(contentsOf: newRepositories)
                    }
                    self?.currentPage += 1
                    
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadMore() {
        if !isLoading {
            fetchRepositories()
        }
    }
    
    func refresh() {
        fetchRepositories(isRefreshing: true)
    }
}
