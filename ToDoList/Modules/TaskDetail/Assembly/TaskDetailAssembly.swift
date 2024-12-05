import UIKit

final class TaskDetailAssembly {
    static func configure(task: TodoTask? = nil) -> UIViewController {
        let view = TaskDetailViewController()
        let router = TaskDetailRouter()
        router.viewController = view
        
        let coreDataManager = CoreDataManager()
        let storageService = TaskStorageService(coreDataManager: coreDataManager)
        let dateFormatterService = DateFormatterService()
        
        let interactor = TaskDetailInteractor(taskStorageService: storageService)
        
        // Если задача не передана, создаем новую
        let taskToUse = task ?? TodoTask(
            id: Int.random(in: 1000...9999),
            title: "",
            description: "",
            completed: false,
            createdAt: Date()
        )
        
        let presenter = TaskDetailPresenter(
            task: taskToUse,
            dateFormatterService: dateFormatterService
        )
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
} 