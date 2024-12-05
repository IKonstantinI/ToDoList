import Foundation

struct TodoTask: Codable {
    let id: Int
    var title: String
    var description: String
    var completed: Bool
    let createdAt: Date
} 