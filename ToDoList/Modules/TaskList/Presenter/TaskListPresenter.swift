import Foundation

final class TaskListPresenter: TaskListPresenterProtocol {
    weak var view: TaskListViewProtocol?
    var router: TaskListRouterProtocol?
    var interactor: TaskListInteractorProtocol?
    
    private var tasks: [TodoTask] = []
    
    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showLoadingIndicator()
        }
        Task {
            do {
                try await interactor?.fetchTasks()
            } catch {
                handleError(error)
            }
        }
    }
    
    func didSelectTask(_ task: TodoTask) {
        router?.navigateToTaskDetail(task)
    }
    
    func didRequestTaskDeletion(_ task: TodoTask) {
        Task {
            do {
                try await interactor?.deleteTask(task)
            } catch {
                handleError(error)
            }
        }
    }
    
    func didRequestTaskStatusChange(_ task: TodoTask) {
        var updatedTask = task
        updatedTask.completed.toggle()
        
        Task {
            do {
                try await interactor?.updateTask(updatedTask)
            } catch {
                handleError(error)
            }
        }
    }
}

// MARK: - TaskListInteractorOutputProtocol
extension TaskListPresenter: TaskListInteractorOutputProtocol {
    func tasksFetched(_ tasks: [TodoTask]) {
        DispatchQueue.main.async { [weak self] in
            self?.tasks = tasks
            self?.view?.hideLoadingIndicator()
            self?.view?.updateTasks()
        }
    }
    
    func taskDeleted(_ task: TodoTask) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                self.tasks.remove(at: index)
                self.view?.updateTasks()
            }
        }
    }
    
    func taskUpdated(_ task: TodoTask) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                self.tasks[index] = task
                self.view?.updateTasks()
            }
        }
    }
    
    func handleError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoadingIndicator()
            self?.view?.showError(error)
        }
    }
} 