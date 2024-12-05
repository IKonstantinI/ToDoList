import Foundation

final class NetworkManager: NetworkServiceProtocol {
    // MARK: - NetworkServiceProtocol
    func fetchTasks(skip: Int, limit: Int) async throws -> TasksResponse {
        let urlString = "https://dummyjson.com/todos"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(TasksResponse.self, from: data)
        return response
    }
}

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
} 