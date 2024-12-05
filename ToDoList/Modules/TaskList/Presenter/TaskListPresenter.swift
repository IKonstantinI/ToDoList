import Foundation

final class TaskListPresenter: TaskListPresenterProtocol {
    weak var view: TaskListViewProtocol?
    var router: TaskListRouterProtocol?
    var interactor: TaskListInteractorProtocol?
    
    private var tasks: [TodoTask] = []
    
    func viewDidLoad() {
        refreshTasks()
    }
    
    func refreshTasks() {
        view?.showLoading()
        Task {
            do {
                try await interactor?.fetchTasks()
            } catch {
                handleError(error)
            }
        }
    }
    
    func searchTasks(query: String) {
        view?.showLoading()
        Task {
            do {
                try await interactor?.searchTasks(query: query)
            } catch {
                handleError(error)
            }
        }
    }
    
    func addNewTask() {
        router?.showTaskDetail(nil)
    }
    
    func didSelectTask(_ task: TodoTask) {
        router?.showTaskDetail(task)
    }
    
    func updateTask(_ task: TodoTask) {
        Task {
            do {
                try await interactor?.updateTask(task)
            } catch {
                handleError(error)
            }
        }
    }
    
    func deleteTask(_ task: TodoTask) {
        Task {
            do {
                try await interactor?.deleteTask(task)
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
            self?.view?.hideLoading()
            self?.view?.showTasks(tasks)
        }
    }
    
    func taskDeleted(_ task: TodoTask) {
        refreshTasks()
    }
    
    func taskUpdated(_ task: TodoTask) {
        refreshTasks()
    }
    
    func handleError(_ error: Error) {
        view?.hideLoading()
        view?.showError(error)
    }
} 