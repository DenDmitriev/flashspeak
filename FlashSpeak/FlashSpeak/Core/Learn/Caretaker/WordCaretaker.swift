//
//  Caretaker.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 04.05.2023.
//

import Foundation

class WordCaretaker {
    
    // MARK: - Propetes
    
    var words: [Word]
    var mistakeWords = [Word: String]()
    
    // MARK: - Constraction
    
    init(words: [Word]) {
        self.words = words
    }
    
    // MARK: - Functions
    
    func addResult(answer: Bool, for wordID: UUID, mistake: String) {
        guard
            let index = words.firstIndex(where: { $0.id == wordID })
        else { return }
        if answer {
            words[index].rightAnswers += 1
        } else {
            words[index].wrongAnswers += 1
            mistakeWords[words[index]] = mistake
            if mistake.isEmpty {
                mistakeWords[words[index]] = NSLocalizedString("Empty", comment: "description").lowercased()
            }
        }
    }
    
    func finish() {
        updateWordInCD()
    }
    
    // MARK: - Private Functions
    
    private func updateWordInCD() {
        words.forEach { word in
            CoreDataManager.instance.updateWord(word, by: word.id)
        }
    }

}
