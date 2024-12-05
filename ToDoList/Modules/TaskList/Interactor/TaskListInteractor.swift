import Foundation

final class TaskListInteractor: TaskListInteractorProtocol {
    weak var presenter: TaskListInteractorOutputProtocol?
    private let taskService: TaskServiceProtocol
    private let storageService: TaskStorageServiceProtocol
    
    init(taskService: TaskServiceProtocol, storageService: TaskStorageServiceProtocol) {
        self.taskService = taskService
        self.storageService = storageService
    }
    
    func fetchTasks() async throws {
        let tasks = try storageService.fetch()
        presenter?.tasksFetched(tasks)
    }
    
    func deleteTask(_ task: TodoTask) async throws {
        try storageService.deleteTask(task)
        presenter?.taskDeleted(task)
    }
    
    func updateTask(_ task: TodoTask) async throws {
        try storageService.updateTask(task)
        presenter?.taskUpdated(task)
    }
    
    func searchTasks(query: String) async throws {
        let tasks = try await storageService.searchTasks(query: query)
        presenter?.tasksFetched(tasks)
    }
} 