import UIKit

protocol TaskCellDelegate: AnyObject {
    func taskCell(_ cell: TaskCell, didRequestDeletionOf task: TodoTask)
    func taskCell(_ cell: TaskCell, didToggleCompletionOf task: TodoTask)
}

final class TaskCell: UITableViewCell {
    static let reuseIdentifier = "TaskCell"
    
    // MARK: - Properties
    weak var delegate: TaskCellDelegate?
    private var task: TodoTask?
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var completionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        button.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.addSubview(completionButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            completionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            completionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completionButton.widthAnchor.constraint(equalToConstant: 24),
            completionButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: completionButton.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -12),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Configuration
    func configure(with task: TodoTask) {
        self.task = task
        titleLabel.text = task.title
        completionButton.isSelected = task.completed
        
        if task.completed {
            titleLabel.textColor = .systemGray
            titleLabel.attributedText = task.title.strikethrough()
        } else {
            titleLabel.textColor = .label
            titleLabel.attributedText = nil
            titleLabel.text = task.title
        }
    }
    
    // MARK: - Actions
    @objc private func completionButtonTapped() {
        guard let task = task else { return }
        delegate?.taskCell(self, didToggleCompletionOf: task)
    }
    
    @objc private func deleteButtonTapped() {
        guard let task = task else { return }
        delegate?.taskCell(self, didRequestDeletionOf: task)
    }
} 