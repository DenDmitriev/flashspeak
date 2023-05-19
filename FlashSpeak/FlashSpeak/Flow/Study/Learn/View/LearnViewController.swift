//
//  LearnViewController.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 04.05.2023.
//
// swiftlint:disable weak_delegate

import UIKit
import Combine

class LearnViewController: UIViewController {
    
    // MARK: - Properties
    
    @Published var question: Question
    @Published var answer: Answer
    
    var settings: LearnSettings
    
    // MARK: - Private properties
    
    private let presenter: LearnViewOutput
    private var store = Set<AnyCancellable>()
    
    // MARK: Question View
    /// View for all types questions by strategy pattern
    var questionViewStrategy: QuestionViewStrategy
    
    // MARK: AnswerView
    /// CollectionView for all types answers by strategy pattern
    var answerViewStrategy: AnswerViewStrategyProtocol
    
    // MARK: - Constraction
    
    init(
        presenter: LearnViewOutput,
        settings: LearnSettings
    ) {
        self.presenter = presenter
        self.settings = settings
        self.question = Question(question: "")
        self.answer = TestAnswer(words: [])
        switch settings.question {
        case .word:
            self.questionViewStrategy = QuestionWordViewStrategy()
        case .image:
            self.questionViewStrategy = QuestionImageViewStrategy()
        case .wordImage:
            self.questionViewStrategy = QuestionWordImageViewStrategy()
        }
        switch settings.answer {
        case .test:
            self.answerViewStrategy = AnswerTestViewStrategy()
        case .keyboard:
            self.answerViewStrategy = AnswerKeyboardViewStrategy()
        }
        super.init(nibName: nil, bundle: nil)
        self.answerViewStrategy.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var learnView: LearnView {
        return view as? LearnView ?? LearnView(
            questionView: questionViewStrategy.view,
            answerView: answerViewStrategy.collectionView
        )
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = LearnView(
            questionView: questionViewStrategy.view,
            answerView: answerViewStrategy.collectionView
        )
        learnView.style = presenter.list.style
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addObserverKayboard()
        subscribe()
        presenter.update()
        configureGesture()
    }
    
    // MARK: - Private functions
    
    private func configureView() {
        learnView.configureView(tabBarHeight: tabBarController?.tabBar.frame.height)
    }
    
    private func updateQuestionView() {
        questionViewStrategy.set(question: question)
    }
    
    private func updateAnswerView() {
        answerViewStrategy.set(answer: answer)
    }
    
    private func configureGesture() {
        if (answerViewStrategy as? AnswerKeyboardViewStrategy) != nil {
            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(dismissKeyboard(sender:))
            )
            tap.cancelsTouchesInView = false
            questionViewStrategy.view.addGestureRecognizer(tap)
        }
    }
    
    // MARK: - Observers
    
    private func subscribe() {
        self.$question
            .combineLatest(self.$answer)
            .receive(on: RunLoop.main)
            .sink { _, answer in
                if answer.answer == nil {
                    self.updateQuestionView()
                    self.updateAnswerView()
                }
            }
            .store(in: &store)
    }
    
    private func addObserverKayboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    // MARK: - Actions
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard
            let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }

        let isKeyboardHide = notification.name == UIResponder.keyboardWillHideNotification
        learnView.updateLayout(isKeyboardHide: isKeyboardHide, keyboardValue: keyboardValue)
    }

    @objc func dismissKeyboard(sender: UIGestureRecognizer) {
        answerViewStrategy.action(.dissmisKeyboard)
    }

}

// MARK: - Functions

extension LearnViewController: LearnViewInput {
    
    func didAnsewred(answer: Answer) {
        presenter.didAnsewred(answer: answer)
    }
    
    func update(exercise: Exercise) {
        question = exercise.question
        answer = exercise.answer
    }
    
    func highlightAnswer(isRight: Bool, index: Int?) {
        answerViewStrategy.highlight(isRight: isRight, index: index ?? .zero)
    }
    
    func setProgress(_ progress: Float) {
        learnView.setProgress(progress)
    }
    
    func spinner(isActive: Bool, title: String?) {
        learnView.spinner(isActive: true, title: title)
    }
    
    func action(closure: @escaping (() -> Void)) {
        closure()
    }
    
}

extension LearnViewController: AnswerViewControllerDelegate {
    func didAnswer(_ answer: Answer) {
        didAnsewred(answer: answer)
    }
}

// swiftlint:enable weak_delegate
