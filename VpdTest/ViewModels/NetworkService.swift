
//
//  NetworkService.swift
//  VpdTest
//
//  Created by DevSampel on 20/03/2025.
//


import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let message):
            return message
        }
    }
}

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func fetchRepositories(page: Int = 1, completion: @escaping (Result<[Repository], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.github.com/repositories?since=\(page * 30)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let repositories = try JSONDecoder().decode([Repository].self, from: data)
                completion(.success(repositories))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
