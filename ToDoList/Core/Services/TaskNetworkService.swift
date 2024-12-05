import Foundation

final class TaskNetworkService {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchTasks() async throws -> [TaskModel] {
        // Реализация сетевых запросов
        return []
    }
    
    func updateTask(_ task: TaskModel) async throws {
        // Реализация обновления задачи на сервере
    }
} 