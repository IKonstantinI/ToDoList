import UIKit

final class TaskDetailView: UIView {
    // MARK: - UI Components
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: TaskDetailConstants.titleFontSize, weight: .bold)
        textField.placeholder = L10n.TaskDetail.titlePlaceholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextView: TaskDetailTextView = {
        let textView = TaskDetailTextView()
        textView.font = .systemFont(ofSize: TaskDetailConstants.descriptionFontSize)
        textView.placeholder = L10n.TaskDetail.descriptionPlaceholder
        textView.layer.cornerRadius = TaskDetailConstants.cornerRadius
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: TaskDetailConstants.statusFontSize, weight: .medium)
        button.layer.cornerRadius = TaskDetailConstants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: TaskDetailConstants.dateFontSize)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubviews(titleTextField, descriptionTextView, statusButton, dateLabel)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: TaskDetailConstants.contentInset.top),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: TaskDetailConstants.contentInset.left),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -TaskDetailConstants.contentInset.right),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: TaskDetailConstants.spacing),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: TaskDetailConstants.contentInset.left),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -TaskDetailConstants.contentInset.right),
            descriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            statusButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: TaskDetailConstants.spacing),
            statusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: TaskDetailConstants.contentInset.left),
            statusButton.heightAnchor.constraint(equalToConstant: 44),
            statusButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            dateLabel.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: TaskDetailConstants.spacing),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: TaskDetailConstants.contentInset.left),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -TaskDetailConstants.contentInset.right)
        ])
    }
    
    // MARK: - Configuration
    func configure(with task: TodoTask) {
        titleTextField.text = task.title
        descriptionTextView.text = task.description.isEmpty ? L10n.TaskDetail.descriptionPlaceholder : task.description
        descriptionTextView.textColor = task.description.isEmpty ? .placeholderText : .label
        
        let statusTitle = task.completed ? L10n.TaskDetail.statusCompleted : L10n.TaskDetail.statusIncomplete
        statusButton.setTitle(statusTitle, for: .normal)
        statusButton.backgroundColor = task.completed ? .systemGreen.withAlphaComponent(0.1) : .systemOrange.withAlphaComponent(0.1)
        statusButton.setTitleColor(task.completed ? .systemGreen : .systemOrange, for: .normal)
        
        dateLabel.text = L10n.TaskDetail.createdAtPrefix + task.createdAt.formatted()
    }
} 