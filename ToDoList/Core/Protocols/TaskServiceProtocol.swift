import Foundation

protocol TaskServiceProtocol {
    func fetchTasks(skip: Int, limit: Int) async throws -> TasksResponse
} 