import UIKit

extension TaskDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == descriptionTextView {
            navigationItem.rightBarButtonItem?.isEnabled = !textView.text.isEmpty
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == descriptionTextView && textView.text == "Описание" {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == descriptionTextView && textView.text.isEmpty {
            textView.text = "Описание"
            textView.textColor = .placeholderText
        }
    }
} 