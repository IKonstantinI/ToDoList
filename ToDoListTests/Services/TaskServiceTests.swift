import XCTest
@testable import ToDoList

class TaskServiceTests: XCTestCase {
    var sut: TaskService!
    var mockNetwork: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkService()
        sut = TaskService(networkService: mockNetwork)
    }
    
    override func tearDown() {
        sut = nil
        mockNetwork = nil
        super.tearDown()
    }
    
    func testFetchTasks() async throws {
        // Arrange
        mockNetwork.mockResponse = TasksResponseStub.valid
        
        // Act
        let result = try await sut.fetchTasks(skip: 0, limit: 10)
        
        // Assert
        XCTAssertEqual(result.todos.count, 10)
    }
    
    func testFetchTasksWithError() async {
        // Arrange
        let expectedError = TaskServiceError.invalidResponse
        mockNetwork.error = expectedError
        
        // Act & Assert
        do {
            _ = try await sut.fetchTasks(skip: 0, limit: 10)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? TaskServiceError, expectedError)
        }
    }
} 