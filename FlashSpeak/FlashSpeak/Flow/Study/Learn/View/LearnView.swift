//
//  LearnView.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 04.05.2023.
//

import UIKit

class LearnView: UIView {
    
    // MARK: - Propeties
    
    /// Question view color
    var style: GradientStyle?
    
    /// Dynamic constraint for question view when keyboard show or hide
    private var questionStackViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    enum QuestionHeightLayout {
        /// initial height question view
        static var initial: CGFloat = UIScreen.main.bounds.height * Grid.factor50
        /// dynamic height question view
        static var height = initial
    }
    
    // MARK: - Subviews
    
    // MARK: Main subview
    
    /// Content view for all subview in self
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            questionStackView,
            answerStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Grid.pt32
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: Question View
    
    /// Content view for all question subviews
    private lazy var questionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            questionLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .zero
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.layer.cornerRadius = Grid.cr16
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    private var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title1
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var questionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Grid.cr16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: AnswerView
    
    /// Content view for all answer subviews
    private lazy var answerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            answersCollectionView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Grid.pt8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    /// Collection view for all types answer
    let answersCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = Grid.cr8
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func draw(_ rect: CGRect) {
        setupAppearance()
    }
    
    override func updateConstraints() {
        questionStackViewHeightConstraint.constant = QuestionHeightLayout.height
        super.updateConstraints()
    }
    
    // MARK: - Functions
    
    /// Update question and answer view
    func set(question: Question, answer: Answer) {
        questionLabel.text = question.question
        if let image = question.image {
            questionImageView.image = image
            questionStackView.insertArrangedSubview(questionImageView, at: .zero)
        } else {
            questionImageView.removeFromSuperview()
        }
    }
    
    /// Highlight answer view
    func highlightAnswer(isRight: Bool?, index: Int) {
        let indexPath = IndexPath(item: index, section: .zero)
        guard
            var cell = answersCollectionView.cellForItem(at: indexPath) as? AnswerCell
        else { return }
        cell.isRight = isRight
    }
    
    /// Compress question view if show keyboard
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        var keyboardFrame: CGRect = frame.cgRectValue
        keyboardFrame = convert(keyboardFrame, from: nil)
        
        let contentSize = questionStackView.frame.height + answerStackView.frame.height
        let layoutSpace = contentStackView.spacing
        let freeSpace = scrollView.frame.height - contentSize + layoutSpace
        let questionStackOffsetHeight = keyboardFrame.size.height - freeSpace
        
        QuestionHeightLayout.height = QuestionHeightLayout.initial - questionStackOffsetHeight
        UIView.animate(withDuration: 0.3) {
            self.setNeedsUpdateConstraints()
            self.layoutIfNeeded()
        }
    }
    
    /// Stretch question view if hide keyboard
    func keyboardWillHide() {
        QuestionHeightLayout.height = QuestionHeightLayout.initial
        UIView.animate(withDuration: 0.3) {
            self.setNeedsUpdateConstraints()
            self.layoutIfNeeded()
        }
    }
    
    /// Clear text in textFiled
    func clearTextFiled() {
        guard
            let cell = answersCollectionView.cellForItem(
                at: IndexPath(item: .zero, section: .zero)
            ) as? AnswerKeyboardCell
        else { return }
        cell.answerTextField.text = nil
    }
    
    // MARK: - UI

    private func configureUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
    }
    
    private func setupAppearance() {
        configureCardStackView()
    }
    
    private func configureCardStackView() {
        let layer = CAGradientLayer.gradientLayer(for: style ?? .grey, in: questionStackView.bounds)
        layer.cornerRadius = Grid.cr16
        questionStackView.layer.insertSublayer(layer, at: 0)
    }
    
    private func configureQuestionHeightConstraint() {
        questionStackViewHeightConstraint = questionStackView.heightAnchor.constraint(
            equalToConstant: QuestionHeightLayout.height
        )
    }
    
    private func setupConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        configureQuestionHeightConstraint()
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            contentStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Grid.pt32),
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            questionStackViewHeightConstraint,
            answerStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.2),
            questionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Grid.pt64)
        ])
    }
}