import UIKit

final class TaskListRouter: TaskListRouterProtocol {
    weak var viewController: UIViewController?
    
    func showTaskDetail(_ task: TodoTask?) {
        let detailVC = TaskDetailAssembly.configure(with: task)
        let navigationController = UINavigationController(rootViewController: detailVC)
        viewController?.present(navigationController, animated: true)
    }
} 