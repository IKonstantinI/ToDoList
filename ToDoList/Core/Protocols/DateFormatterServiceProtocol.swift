import Foundation

protocol DateFormatterServiceProtocol {
    func format(_ date: Date) -> String
    func formatTaskDate(_ date: Date) -> String
} 
