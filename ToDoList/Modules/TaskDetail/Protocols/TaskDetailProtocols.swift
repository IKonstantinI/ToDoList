import Foundation
import UIKit

// MARK: - View
protocol TaskDetailViewProtocol: AnyObject {
    func display(_ viewModel: TaskDetailViewModel)
    func showError(_ error: Error)
}

// MARK: - Presenter
protocol TaskDetailPresenterProtocol: AnyObject {
    var view: TaskDetailViewProtocol? { get set }
    var router: TaskDetailRouterProtocol? { get set }
    var interactor: TaskDetailInteractorProtocol? { get set }
    
    func viewDidLoad()
    func saveTask(title: String, description: String)
    func toggleTaskStatus()
    func setTask(_ task: TodoTask)
}

// MARK: - Interactor
protocol TaskDetailInteractorProtocol: AnyObject {
    var presenter: TaskDetailInteractorOutputProtocol? { get set }
    func updateTask(_ task: TodoTask) async throws
}

// MARK: - Interactor Output
protocol TaskDetailInteractorOutputProtocol: AnyObject {
    func taskUpdated(_ task: TodoTask)
    func errorOccurred(_ error: Error)
}

// MARK: - Router
protocol TaskDetailRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func dismiss()
} 