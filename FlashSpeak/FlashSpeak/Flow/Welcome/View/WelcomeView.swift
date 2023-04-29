//
//  WelcomeView.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 28.04.2023.
//

import UIKit

class WelcomeView: UIView {
    
    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption1
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let sourcelanguageLabel: UILabel = languageLabel()
    private let targetlanguageLabel: UILabel = languageLabel()
    let sourcelanguageButton: UIButton = languageButton()
    let targetlanguageButton: UIButton = languageButton()
    
    let eventButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.appFilled())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            sourcelanguageLabel,
            sourcelanguageButton,
            targetlanguageLabel,
            targetlanguageButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Grid.pt16
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Constraction
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundLightGray
        configureTitles()
        addSubview(stackView)
        addSubview(eventButton)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Functions
    
    func configureButtons(type: Language.LanguageType, language: Language) {
        switch type {
        case .source:
            configureContentButton(sourcelanguageButton, language)
        case .target:
            configureContentButton(targetlanguageButton, language)
        }
    }
    
    // MARK: - Private functions
    
    private static func languageLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title3
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }
    
    private static func languageButton() -> UIButton {
        var configuration = UIButton.Configuration.borderless()
        configuration.imagePlacement = .bottom
        configuration.imagePadding = Grid.pt8
        configuration.buttonSize = .medium
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: Grid.pt8,
            leading: Grid.pt16,
            bottom: Grid.pt16,
            trailing: Grid.pt16
        )
        let button = UIButton(configuration: configuration)
        button.imageView?.layer.cornerRadius = Grid.cr8
        button.imageView?.layer.masksToBounds = true
        return button
    }
    
    private func configureTitles() {
        let title = NSLocalizedString("Добро пожаловать", comment: "Title")
        let subtitle = NSLocalizedString("Перед началом работы нам нужно знать какой язык вы будете изучать", comment: "Title")
        let sourcelanguageTitle = NSLocalizedString("Ваш родной язык", comment: "Title")
        let targetlanguageTitle = NSLocalizedString("Язык изучения", comment: "Title")
        let eventButtonTitle = NSLocalizedString("Начать", comment: "Button")
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        sourcelanguageLabel.text = sourcelanguageTitle
        targetlanguageLabel.text = targetlanguageTitle
        eventButton.setTitle(eventButtonTitle, for: .normal)
    }
    
    private func configureContentButton(_ button: UIButton, _ source: Language) {
        let title = source.description
        let image = UIImage(named: source.code)
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
    }
    
    // MARK: - Constraints
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Grid.pt16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Grid.pt16),
            
            eventButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            eventButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Grid.pt96)
        ])
    }

}