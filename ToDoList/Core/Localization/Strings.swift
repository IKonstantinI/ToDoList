import Foundation

enum L10n {
    enum TaskList {
        static let title = "Задачи"
        static let searchPlaceholder = "Поиск задач"
        static let deleteAction = "Удалить"
        static let completeAction = "Выполнено"
        static let incompleteAction = "Не выполнено"
    }
    
    enum TaskDetail {
        static let title = "Детали задачи"
        static let saveButton = "Сохранить"
        static let titlePlaceholder = "Введите название задачи"
        static let descriptionPlaceholder = "Введите описание задачи"
        static let statusCompleted = "Выполнено"
        static let statusIncomplete = "Не выполнено"
        static let createdAtPrefix = "Создано: "
        static let errorTitle = "Ошибка"
        static let emptyTitleError = "Заголовок задачи не может быть пустым"
    }
    
    enum Common {
        static let error = "Ошибка"
        static let ok = "OK"
    }
} 