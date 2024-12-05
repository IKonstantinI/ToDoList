import Foundation
import UIKit

// MARK: - View
protocol TaskListViewProtocol: AnyObject {
    var presenter: TaskListPresenterProtocol? { get set }
    
    func showTasks(_ tasks: [TodoTask])
    func showError(_ error: Error)
    func showLoading()
    func hideLoading()
}

// MARK: - Presenter
protocol TaskListPresenterProtocol: AnyObject {
    var view: TaskListViewProtocol? { get set }
    var router: TaskListRouterProtocol? { get set }
    var interactor: TaskListInteractorProtocol? { get set }
    
    func viewDidLoad()
    func refreshTasks()
    func searchTasks(query: String)
    func addNewTask()
    func didSelectTask(_ task: TodoTask)
    func updateTask(_ task: TodoTask)
    func deleteTask(_ task: TodoTask)
}

// MARK: - Interactor
protocol TaskListInteractorProtocol: AnyObject {
    var presenter: TaskListInteractorOutputProtocol? { get set }
    
    func fetchTasks() async throws
    func searchTasks(query: String) async throws
    func updateTask(_ task: TodoTask) async throws
    func deleteTask(_ task: TodoTask) async throws
}

// MARK: - InteractorOutput
protocol TaskListInteractorOutputProtocol: AnyObject {
    func tasksFetched(_ tasks: [TodoTask])
    func taskDeleted(_ task: TodoTask)
    func taskUpdated(_ task: TodoTask)
    func handleError(_ error: Error)
}

// MARK: - Router
protocol TaskListRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func showTaskDetail(_ task: TodoTask?)
} 
