import Foundation

final class TaskDetailInteractor: TaskDetailInteractorProtocol {
    // MARK: - Properties
    weak var presenter: TaskDetailInteractorOutputProtocol?
    private let taskStorageService: TaskStorageServiceProtocol
    
    // MARK: - Initialization
    init(taskStorageService: TaskStorageServiceProtocol) {
        self.taskStorageService = taskStorageService
    }
    
    // MARK: - TaskDetailInteractorProtocol
    func updateTask(_ task: TodoTask) async throws {
        try taskStorageService.updateTask(task)
        presenter?.taskUpdated(task)
    }
} 