
//
//  RepositoryRowView.swift
//  VpdTest
//
//  Created by DevSampel on 20/03/2025.
//

import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: repository.owner.avatarUrl)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(1.33, contentMode: .fit)
                        .overlay(ProgressView())
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                case .failure(_):
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(1.33, contentMode: .fit)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(repository.name)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(1)
                
                HStack {
                    Image(systemName: "eye")
                        .font(.system(size: 12))
                    Text("\(repository.stargazersCount ?? 0) view")
                        .font(.system(size: 12))
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "bookmark")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
