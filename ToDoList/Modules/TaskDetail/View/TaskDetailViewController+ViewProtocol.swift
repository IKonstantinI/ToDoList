import UIKit

extension TaskDetailViewController: TaskDetailViewProtocol {
    override func showError(_ error: Error) {
        super.showError(error)
        // дополнительная логика если нужна
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
} 