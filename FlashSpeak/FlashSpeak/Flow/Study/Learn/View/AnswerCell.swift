//
//  AnswerCell.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 05.05.2023.
//

import UIKit

class AnswerCell: UICollectionViewCell {
    
    // MARK: Propetes
    
    var isRight: Bool?
    
    static let identifier = "Answer cell"
    
    // MARK: - Subviews
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title3
        label.textAlignment = .center
        label.numberOfLines = 1
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
        backgroundColor = .backgroundLightGray
    }
    
    // MARK: - UI
    
    private func configureView() {
        backgroundColor = .backgroundLightGray
        layer.masksToBounds = true
        layer.cornerRadius = frame.height / 2
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
            answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
