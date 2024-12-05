import Foundation

protocol TaskCellDelegate: AnyObject {
    func taskCell(_ cell: TaskCell, didToggleCompletionOf task: TodoTask)
    func taskCell(_ cell: TaskCell, didRequestDeletionOf task: TodoTask)
} 