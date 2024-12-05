import UIKit

final class TaskListAssembly {
    static func configure() -> UIViewController {
        let view = TaskListViewController()
        let router = TaskListRouter()
        router.viewController = view
        
        let networkService = NetworkManager()
        let taskService = TaskService(networkService: networkService)
        let coreDataManager = CoreDataManager()
        let storageService = TaskStorageService(coreDataManager: coreDataManager)
        let interactor = TaskListInteractor(taskService: taskService, storageService: storageService)
        let presenter = TaskListPresenter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
} 