import CoreData

extension TaskEntity {
    static func create(from task: TodoTask, in context: NSManagedObjectContext) -> TaskEntity {
        let entity = TaskEntity(context: context)
        entity.configure(with: task)
        return entity
    }
    
    func configure(with task: TodoTask) {
        self.id = Int64(task.id)
        self.title = task.title
        self.taskDescription = task.description
        self.completed = task.completed
        self.createdAt = task.createdAt
    }
} 