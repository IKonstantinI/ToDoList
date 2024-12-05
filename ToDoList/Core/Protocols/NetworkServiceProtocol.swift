import Foundation

protocol NetworkServiceProtocol {
    func fetchTasks(skip: Int, limit: Int) async throws -> TasksResponse
} 