import Foundation

extension TodoTask {
    init(from model: TaskModel) {
        self.init(
            id: model.id,
            title: model.title,
            description: model.description ?? "",
            completed: model.isCompleted,
            createdAt: model.createdAt
        )
    }
}

extension TaskModel {
    init(from task: TodoTask) {
        self.init(
            id: task.id,
            title: task.title,
            description: task.description,
            isCompleted: task.completed,
            createdAt: task.createdAt
        )
    }
}
