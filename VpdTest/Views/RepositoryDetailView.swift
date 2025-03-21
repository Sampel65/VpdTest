//
//  RepositoryDetailView.swift
//  VpdTest
//
//  Created by DevSampel on 20/03/2025.
//

import SwiftUI

struct RepositoryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let repository: Repository
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header with navigation icons
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    HStack(spacing: 20) {
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        Button(action: {}) {
                            Image(systemName: "bookmark")
                        }
                    }
                }
                .padding()
                
                // Repository avatar
                AsyncImage(url: URL(string: repository.owner.avatarUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                    case .failure:
                        Color.gray
                            .frame(height: 300)
                    @unknown default:
                        Color.gray
                            .frame(height: 300)
                    }
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    // Repository stats
                    if let stars = repository.stargazersCount {
                        Text("⭐ \(stars)")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(20)
                            .padding(.top)
                    }
                    
                    // Repository name and description
                    Text(repository.fullName)
                        .font(.title2)
                        .bold()
                    
                    if let description = repository.description {
                        Text(description)
                            .foregroundColor(.secondary)
                    }
                    
                    // Repository details
                    if let language = repository.language {
                        HStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 12, height: 12)
                            Text(language)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Additional sections
                    VStack(spacing: 16) {
                        DisclosureGroup("Repository Details") {
                            VStack(alignment: .leading) {
                                if let language = repository.language {
                                    Text("Language: \(language)")
                                }
                                Text("Name: \(repository.name)")
                            }
                            .padding(.vertical)
                        }
                        
                        DisclosureGroup("Owner Information") {
                            VStack(alignment: .leading) {
                                Text("Owner: \(repository.owner.login)")
                            }
                            .padding(.vertical)
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}
