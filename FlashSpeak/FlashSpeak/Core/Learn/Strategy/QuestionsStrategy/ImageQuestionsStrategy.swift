//
//  ImageQuestionsStrategy.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 04.05.2023.
//

import Foundation

class ImageQuestionsStrategy: QuestionsStrategy {
    
    func createQuestions(_ words: [Word], source: LearnSettings.Language) -> [Question] {
        let questions: [Question] = words.map { word in
            
            var question: Question
            
            switch source {
            case .source:
                question = Question(question: word.translation, image: nil)
            case .target:
                question = Question(question: word.source, image: nil)
            }
            
            return question
            
        }
        return questions
    }
}
