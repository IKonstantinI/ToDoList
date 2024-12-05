import UIKit

final class TaskListRouter: TaskListRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToTaskDetail(_ task: TodoTask) {
        let detailVC = TaskDetailAssembly.configure(task: task)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func navigateToNewTask() {
        let detailVC = TaskDetailAssembly.configure()
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
} 