import Foundation

enum TaskError: LocalizedError {
    case taskNotFound
    case saveFailed
    case deleteFailed
    case updateFailed
    case fetchFailed
    case emptyTitle
    
    var errorDescription: String? {
        switch self {
        case .taskNotFound:
            return "Задача не найдена"
        case .saveFailed:
            return "Не удалось сохранить задачу"
        case .deleteFailed:
            return "Не удалось удалить задачу"
        case .updateFailed:
            return "Не удалось обновить задачу"
        case .fetchFailed:
            return "Не удалось загрузить задачи"
        case .emptyTitle:
            return "Заголовок не может быть пустым"
        }
    }
}