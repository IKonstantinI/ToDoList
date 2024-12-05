import Foundation

final class TaskDetailPresenter: TaskDetailPresenterProtocol {
    // MARK: - Properties
    weak var view: TaskDetailViewProtocol?
    var router: TaskDetailRouterProtocol?
    var interactor: TaskDetailInteractorProtocol?
    private let dateFormatter: DateFormatterServiceProtocol
    
    private var task: TodoTask?
    
    init(dateFormatter: DateFormatterServiceProtocol) {
        self.dateFormatter = dateFormatter
    }
    
    // MARK: - TaskDetailPresenterProtocol
    func viewDidLoad() {
        if let task = task {
            let viewModel = TaskDetailViewModel(
                title: task.title,
                description: task.description,
                date: dateFormatter.format(date: task.createdAt),
                isCompleted: task.completed
            )
            view?.display(viewModel)
        }
    }
    
    func saveTask(title: String, description: String) {
        guard !title.isEmpty else {
            view?.showError(TaskError.emptyTitle)
            return
        }
        
        Task {
            do {
                if var existingTask = task {
                    existingTask.title = title
                    existingTask.description = description
                    try await interactor?.updateTask(existingTask)
                } else {
                    let newTask = TodoTask(
                        id: Int.random(in: 1...Int.max),
                        title: title,
                        description: description,
                        completed: false,
                        createdAt: Date()
                    )
                    try await interactor?.updateTask(newTask)
                }
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
        guard var task = task else { return }
        task.completed.toggle()
        
        Task {
            do {
                try await interactor?.updateTask(task)
            } catch {
                await MainActor.run {
                    view?.showError(error)
                }
            }
        }
    }
    
    func setTask(_ task: TodoTask) {
        self.task = task
    }
}

// MARK: - TaskDetailInteractorOutputProtocol
extension TaskDetailPresenter: TaskDetailInteractorOutputProtocol {
    func taskUpdated(_ task: TodoTask) {
        Task { @MainActor in
            router?.dismiss()
        }
    }
    
    func errorOccurred(_ error: Error) {
        Task { @MainActor in
            view?.showError(error)
        }
    }
} 