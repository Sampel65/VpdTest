import Foundation

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let owner: Owner
    let stargazersCount: Int?
    let language: String?
    
    var uniqueId: String {
        "\(id)-\(fullName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description
        case owner
        case stargazersCount = "stargazers_count"
        case language
    }
}

struct Owner: Codable {
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
