import Foundation

final class TaskService: TaskServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTasks(skip: Int = AppConfig.API.Parameters.initialSkip, 
                    limit: Int = AppConfig.API.Parameters.defaultPageSize) async throws -> TasksResponse {
        return try await networkService.fetchTasks(skip: skip, limit: limit)
    }
}

struct TasksResponse: Codable {
    let todos: [TodoTask]
    let total: Int
    let skip: Int
    let limit: Int
} 