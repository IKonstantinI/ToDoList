import Foundation

protocol TaskStorageServiceProtocol {
    func save(_ task: TodoTask) throws
    func fetch() throws -> [TodoTask]
    func updateTask(_ task: TodoTask) throws
    func deleteTask(_ task: TodoTask) throws
    func fetchTask(byId id: Int) throws -> TodoTask?
} 