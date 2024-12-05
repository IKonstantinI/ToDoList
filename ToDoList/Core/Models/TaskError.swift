import Foundation

enum TaskError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError(Error)
    case taskNotFound
    case emptyTitle
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case .invalidResponse:
            return "Неверный ответ от сервера"
        case .serverError(let code):
            return "Ошибка сервера: \(code)"
        case .decodingError:
            return "Ошибка при обработке данных"
        case .taskNotFound:
            return "Задача не найдена"
        case .emptyTitle:
            return "Заголовок не может быть пустым"
        }
    }
}