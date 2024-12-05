struct TaskDetailViewModel {
    let title: String
    let description: String
    let date: String
    let isCompleted: Bool
    
    init(title: String, description: String, date: String, isCompleted: Bool) {
        self.title = title
        self.description = description
        self.date = date
        self.isCompleted = isCompleted
    }
} 