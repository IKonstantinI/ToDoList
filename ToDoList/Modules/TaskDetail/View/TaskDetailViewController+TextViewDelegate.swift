import UIKit

extension TaskDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == detailView.descriptionTextView {
            updateSaveButtonVisibility()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == detailView.descriptionTextView && textView.text == L10n.TaskDetail.descriptionPlaceholder {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == detailView.descriptionTextView && textView.text.isEmpty {
            textView.text = L10n.TaskDetail.descriptionPlaceholder
            textView.textColor = .placeholderText
        }
    }
} 