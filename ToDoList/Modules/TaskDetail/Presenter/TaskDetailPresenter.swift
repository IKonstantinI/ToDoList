import Foundation

final class TaskDetailPresenter: TaskDetailPresenterProtocol {
    // MARK: - Properties
    weak var view: TaskDetailViewProtocol?
    var router: TaskDetailRouterProtocol?
    var interactor: TaskDetailInteractorProtocol?
    private var task: TodoTask
    private let dateFormatterService: DateFormatterServiceProtocol
    
    // MARK: - Initialization
    init(task: TodoTask, dateFormatterService: DateFormatterServiceProtocol) {
        self.task = task
        self.dateFormatterService = dateFormatterService
    }
    
    // MARK: - TaskDetailPresenterProtocol
    func viewDidLoad() {
        if let detailView = view as? TaskDetailViewController {
            detailView.detailView.configure(with: task)
        }
    }
    
    func saveTask(title: String, description: String) {
        guard !title.trimmed.isEmpty else {
            view?.showError(TaskError.emptyTitle)
            return
        }
        
        var updatedTask = task
        updatedTask.title = title.trimmed
        updatedTask.description = description.trimmed
        
        Task {
            do {
                try await interactor?.updateTask(updatedTask)
                await MainActor.run {
                    router?.dismiss()
                }
            } catch {
                await MainActor.run {
                    view?.showError(error)
                }
            }
        }
    }
    
    func toggleTaskStatus() {
        task.completed.toggle()
        Task {
            do {
                try await interactor?.updateTask(task)
            } catch {
                view?.showError(error)
            }
        }
    }
}

// MARK: - TaskDetailInteractorOutputProtocol
extension TaskDetailPresenter: TaskDetailInteractorOutputProtocol {
    func taskUpdated(_ task: TodoTask) {
        router?.dismiss()
    }
    
    func errorOccurred(_ error: Error) {
        view?.showError(error)
    }
} 