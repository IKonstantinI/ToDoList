import UIKit

final class TaskDetailRouter: TaskDetailRouterProtocol {
    // MARK: - Properties
    weak var viewController: UIViewController?
    
    // MARK: - TaskDetailRouterProtocol
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
} 