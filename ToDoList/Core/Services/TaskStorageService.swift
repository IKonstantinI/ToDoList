import Foundation
import CoreData

final class TaskStorageService: TaskStorageServiceProtocol {
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    private func mapTaskToEntity(_ task: TodoTask, _ taskEntity: TaskEntity) {
        taskEntity.id = Int64(task.id)
        taskEntity.title = task.title
        taskEntity.taskDescription = task.description
        taskEntity.completed = task.completed
        taskEntity.createdAt = task.createdAt
    }
    
    private func mapEntityToTask(_ entity: TaskEntity) -> TodoTask {
        return TodoTask(
            id: Int(entity.id),
            title: entity.title ?? "",
            description: entity.taskDescription ?? "",
            completed: entity.completed,
            createdAt: entity.createdAt ?? Date()
        )
    }
    
    func save(_ task: TodoTask) throws {
        let context = coreDataManager.viewContext
        let taskEntity = TaskEntity(context: context)
        mapTaskToEntity(task, taskEntity)
        try context.save()
    }
    
    func fetch() throws -> [TodoTask] {
        let context = coreDataManager.viewContext
        let request = TaskEntity.fetchRequest()
        let entities = try context.fetch(request)
        return entities.map { mapEntityToTask($0) }
    }
    
    func updateTask(_ task: TodoTask) throws {
        let context = coreDataManager.viewContext
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", task.id)
        
        guard let entity = try context.fetch(request).first else {
            throw TaskError.taskNotFound
        }
        
        mapTaskToEntity(task, entity)
        try context.save()
    }
    
    func deleteTask(_ task: TodoTask) throws {
        let context = coreDataManager.viewContext
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", task.id)
        
        guard let entity = try context.fetch(request).first else {
            throw TaskError.taskNotFound
        }
        
        context.delete(entity)
        try context.save()
    }
    
    func fetchTask(byId id: Int) throws -> TodoTask? {
        let context = coreDataManager.viewContext
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        guard let entity = try context.fetch(request).first else {
            return nil
        }
        
        return mapEntityToTask(entity)
    }
    
    func searchTasks(query: String) async throws -> [TodoTask] {
        let tasks = try fetch()
        if query.isEmpty {
            return tasks
        }
        return tasks.filter { task in
            task.title.localizedCaseInsensitiveContains(query) ||
            task.description.localizedCaseInsensitiveContains(query)
        }
    }
} 