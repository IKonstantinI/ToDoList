import Foundation

final class DateFormatterService: DateFormatterServiceProtocol {
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
    }
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
} 