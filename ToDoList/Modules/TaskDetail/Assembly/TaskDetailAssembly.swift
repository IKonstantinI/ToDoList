import UIKit

final class TaskDetailAssembly {
    static func configure(with task: TodoTask? = nil) -> UIViewController {
        let view = TaskDetailViewController()
        let router = TaskDetailRouter()
        let dateFormatter = DateFormatterService()
        let presenter = TaskDetailPresenter(dateFormatter: dateFormatter)
        
        let coreDataManager = CoreDataManager()
        let storageService = TaskStorageService(coreDataManager: coreDataManager)
        let interactor = TaskDetailInteractor(taskStorageService: storageService)
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        if let task = task {
            presenter.setTask(task)
        }
        
        return view
    }
} 