import CoreData

final class CoreDataManager: CoreDataManagerProtocol {
    // MARK: - Properties
    private let modelName = "ToDoList"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Task Operations
    func saveInitialTasks(_ tasks: [TodoTask]) throws {
        let context = viewContext
        tasks.forEach { task in
            _ = TaskEntity.create(from: task, in: context)
        }
        try context.save()
    }
    
    func saveTask(_ task: TodoTask) throws {
        let context = viewContext
        _ = TaskEntity.create(from: task, in: context)
        try context.save()
    }
    
    func fetchTasks() throws -> [TodoTask] {
        let context = viewContext
        let request = TaskEntity.fetchRequest()
        let taskEntities = try context.fetch(request)
        return taskEntities.map { entity in
            TodoTask(
                id: Int(entity.id),
                title: entity.title ?? "",
                description: entity.taskDescription ?? "",
                completed: entity.completed,
                createdAt: entity.createdAt ?? Date()
            )
        }
    }
    
    func updateTask(_ task: TodoTask) throws {
        let context = viewContext
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", task.id)
        
        guard let taskEntity = try context.fetch(request).first else {
            throw TaskError.taskNotFound
        }
        
        taskEntity.configure(with: task)
        try context.save()
    }
    
    func deleteTask(_ task: TodoTask) throws {
        let context = viewContext
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", task.id)
        
        guard let taskEntity = try context.fetch(request).first else {
            throw TaskError.taskNotFound
        }
        
        context.delete(taskEntity)
        try context.save()
    }
    
    func searchTasks(query: String) throws -> [TodoTask] {
        let context = viewContext
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR taskDescription CONTAINS[cd] %@", query, query)
        
        let taskEntities = try context.fetch(request)
        return taskEntities.map { entity in
            TodoTask(
                id: Int(entity.id),
                title: entity.title ?? "",
                description: entity.taskDescription ?? "",
                completed: entity.completed,
                createdAt: entity.createdAt ?? Date()
            )
        }
    }
} 