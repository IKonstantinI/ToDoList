struct TaskDetailViewModel {
    let title: String
    let description: String
    let date: String
    let isCompleted: Bool
    
    static let empty = TaskDetailViewModel(
        title: "",
        description: "",
        date: "",
        isCompleted: false
    )
    
    init(task: TodoTask, dateFormatter: DateFormatterServiceProtocol) {
        self.title = task.title
        self.description = task.description
        self.date = dateFormatter.formatTaskDate(task.createdAt)
        self.isCompleted = task.completed
    }
    
    init(title: String, description: String, date: String, isCompleted: Bool) {
        self.title = title
        self.description = description
        self.date = date
        self.isCompleted = isCompleted
    }
} 