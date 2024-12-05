import Foundation

enum AppConfig {
    enum API {
        static let baseURL = "https://dummyjson.com"
        
        enum Endpoints {
            static let todos = "/todos"
        }
        
        enum Parameters {
            static let initialSkip = 0
            static let defaultPageSize = 20
        }
    }
} 