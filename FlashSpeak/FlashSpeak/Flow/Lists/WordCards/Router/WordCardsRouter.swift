//
//  WordCardsRouter.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 26.04.2023.
//

import Foundation

protocol WordCardsEvent {
    var didSendEventClosure: ((WordCardsRouter.Event) -> Void)? { get set }
}

class WordCardsRouter: WordCardsEvent {
    
    enum Event {
        case word(word: Word)
    }
    
    var didSendEventClosure: ((Event) -> Void)?
}