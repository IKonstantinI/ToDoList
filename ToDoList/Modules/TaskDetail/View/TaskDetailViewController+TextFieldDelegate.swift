import UIKit

extension TaskDetailViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateSaveButtonVisibility()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        detailView.descriptionTextView.becomeFirstResponder()
        return true
    }
} 