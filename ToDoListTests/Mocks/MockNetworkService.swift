import Foundation
@testable import ToDoList

class MockNetworkService: NetworkServiceProtocol {
    var mockResponse: TasksResponse?
    var error: Error?
    
    func fetchTasks(skip: Int, limit: Int) async throws -> TasksResponse {
        if let error = error {
            throw error
        }
        return mockResponse ?? TasksResponseStub.valid
    }
}

enum TasksResponseStub {
    static let valid = TasksResponse(
        todos: Array(repeating: TodoTask(
            id: 1,
            title: "Test Task",
            description: "Test Description",
            completed: false,
            userId: 1,
            createdAt: Date()
        ), count: 10),
        total: 10,
        skip: 0,
        limit: 10
    )
} 