import UIKit

final class TaskDetailViewController: UIViewController {
    // MARK: - UI Components
    private(set) lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название задачи"
        textField.font = .systemFont(ofSize: 17, weight: .medium)
        textField.borderStyle = .none
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var titleSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15)
        textView.text = "Описание"
        textView.textColor = .placeholderText
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        button.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    var presenter: TaskDetailPresenterProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        title = "Задача"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .done,
            target: self,
            action: #selector(saveButtonTapped)
        )
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    // MARK: - Actions
    @objc private func saveButtonTapped() {
        presenter?.saveTask(
            title: titleTextField.text ?? "",
            description: descriptionTextView.text
        )
    }
    
    @objc private func toggleButtonTapped() {
        presenter?.toggleTaskStatus()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleTextField)
        view.addSubview(titleSeparatorView)
        view.addSubview(descriptionTextView)
        view.addSubview(dateLabel)
        view.addSubview(toggleButton)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 44),
            
            titleSeparatorView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor),
            titleSeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleSeparatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleSeparatorView.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 120),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            toggleButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            toggleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            toggleButton.widthAnchor.constraint(equalToConstant: 32),
            toggleButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
} 