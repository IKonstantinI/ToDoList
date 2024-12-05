import UIKit

extension TaskDetailViewController: TaskDetailViewProtocol {
    func display(_ viewModel: TaskDetailViewModel) {
        titleTextField.text = viewModel.title
        descriptionTextView.text = viewModel.description
        dateLabel.text = viewModel.date
        toggleButton.isSelected = viewModel.isCompleted
        
        if viewModel.isCompleted {
            toggleButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            toggleButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    override func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
} 