//
//  AnswerWordCell.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 05.05.2023.
//

import UIKit

class AnswerWordCell: UICollectionViewCell, AnswerCell {
    
    // MARK: - Propetes
    
    static let identifier = "AnswerWordCell"
    
    var isRight: Bool? {
        didSet {
            switch isRight {
            case true:
                UIView.animate(withDuration: 0.2) {
                    self.backgroundColor = .systemGreen.withAlphaComponent(Grid.factor50)
                }
            case false:
                answerLabel.shake()
                UIView.animate(withDuration: 0.2) {
                    self.backgroundColor = .systemRed.withAlphaComponent(Grid.factor50)
                }
            default:
                return
            }
        }
    }
    
    // MARK: - Subviews
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .titleBold3
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubviews()
        addConstraints()
    }
    
    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        isSelected = false
        isRight = nil
        backgroundColor = .fiveBackgroundColor
    }
    
    // MARK: - UI
    
    private func configureView() {
        backgroundColor = .fiveBackgroundColor
        layer.masksToBounds = true
        layer.cornerRadius = Grid.cr8
    }
    
    private func configureSubviews() {
        contentView.addSubview(answerLabel)
    }
    
    // MARK: - Methods
    
    func configure(text: String) {
        answerLabel.text = text
    }
    
    // MARK: - Constraints
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Grid.pt8),
            answerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Grid.pt8),
            answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
