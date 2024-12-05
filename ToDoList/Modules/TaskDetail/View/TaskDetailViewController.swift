import UIKit

final class TaskDetailViewController: UIViewController {
    // MARK: - Properties
    var presenter: TaskDetailPresenterProtocol?
    let detailView = TaskDetailView()
    private let dateFormatter: DateFormatterServiceProtocol
    
    // MARK: - Initialization
    init(dateFormatter: DateFormatterServiceProtocol = DateFormatterService()) {
        self.dateFormatter = dateFormatter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = L10n.TaskDetail.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: L10n.TaskDetail.saveButton,
            style: .done,
            target: self,
            action: #selector(saveButtonTapped)
        )
        
        detailView.statusButton.addTarget(
            self,
            action: #selector(statusButtonTapped),
            for: .touchUpInside
        )
        
        updateSaveButtonVisibility()
    }
    
    private func setupDelegates() {
        detailView.titleTextField.delegate = self
        detailView.descriptionTextView.delegate = self
    }
    
    // MARK: - Actions
    @objc private func saveButtonTapped() {
        presenter?.saveTask(
            title: detailView.titleTextField.text ?? "",
            description: detailView.descriptionTextView.text
        )
    }
    
    @objc private func statusButtonTapped() {
        presenter?.toggleTaskStatus()
    }
    
    // MARK: - Helpers
    func updateSaveButtonVisibility() {
        navigationItem.rightBarButtonItem?.isEnabled = !(detailView.titleTextField.text?.isEmpty ?? true)
    }
} 